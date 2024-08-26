Return-Path: <linux-kernel+bounces-301468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFFE95F15B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE141C219AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62201514F6;
	Mon, 26 Aug 2024 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/UWShH+"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FF622071
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675693; cv=none; b=JzIqqX/qhQHndYh92Qmm+QHkjKN3ar9vYvKtZpkguls2d3SwLavcO2Te1fs6xQh/webs8QsF/uKGPgDb/+OiP1mlK44z115ndQaej0f1bhRQUw8pWe/WlJ1AhVQHQ+LLwGLWF7qzgDRJ1B95WXK3mgD8psTSaaUWIa2MTpZLUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675693; c=relaxed/simple;
	bh=D5yV+pWU0soMjkUxmsoXdYLZ7DySNZblVJ7OYZ2lfkU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=P1UmaTQTJ/yuG/lQxat+EaV7M0D0Hg53My3I91LucPe+E+KSSdZywP4RUeHrxBkq5tE+6ItHhRkdJ4z2sH6W4kE+B/Nbsl7ijNzkyL8AXhieqmGBUG3x8qXP8ZJ7azs4w2VR+UV05zcmp3O+jw0hp0lbE0PnoPUJtlJY3C+yhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/UWShH+; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6c1ed19b25fso33747707b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724675690; x=1725280490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2hTGK/L/GSZPz5U8eA2D4ngEFX1RZ6RuzHzDbE5KYPE=;
        b=A/UWShH+NQ+oLNvONAVCRDZTjyKojOf+Tw7bUYxZO21D2vSYSjtTg6hWsyQwi+/CjY
         gPfateYz50S33bH4m0HRAMglUZOeG2eYnMLSfdzo0UzER3093nRTyymPR9E0Q6k1KQkl
         ZHP9bJAAI1vRPOs7277SVweyaCqGcJB7OcAxdxcry2ImPPqweuXM/bj9iqwzoM/iRGV0
         lNad+1LgPO+6p+9DACb1mldCvRk2zIBR2FGhS5f/Is2iXXCaz/hyDu2sD/1bUUrGTsj7
         Tgl1vMHOuRabrZD1h2UI+UjRbWRJUnI5kGh+/1v8fuFN8/tfG+AZjNUAU4358IoF6c/6
         ROZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675690; x=1725280490;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hTGK/L/GSZPz5U8eA2D4ngEFX1RZ6RuzHzDbE5KYPE=;
        b=dnMPa/0olUFhLyDgdTRbz54Hg2bx3q3G9ZtJn0zPZF9OrkBpzkWHwSOK2458YVzZ7Y
         5hsdPRCBy+JxEC/+hAXTFmSRyJYO2uD12PMKXKmRVViLTxK3Y5RtbDdvBar8kBmDhVSV
         Y3KEKyByV8qSO2eyCK73qN7LxGiAtvb8lfF0zQRPs1O6U3jWNn3uwA01tc/9qRpw58bw
         283DpZ+PyBq+XaAW4bKNVt99SCf1VaplEzGDf1Xp+6zU+sfpEEaJVKiKsOvm2XyjoSJA
         ZNrg5Yaj+wuY7BfiFo6ACKJoAyDP5brVSz11c80MpLV8DwuAeLw3gm6M0VsekSlgyg6w
         CilA==
X-Gm-Message-State: AOJu0YzAmLG8qxNq/tquROFsoM0l2L0ENaF/k/3sktgvHCWEVp2G7pKN
	ksDPgzyiYb9JlwI9sgupWWd/tjtZe8VEjWSh6O+Zl0/TtOvRuVVo3DJ9lCIYO1r7P9B2Zcs0JRb
	7Kijm5I864MFFHFlbJzkPDZ8NuQw/tMrL
X-Google-Smtp-Source: AGHT+IG+Q5iwqAfvDa8O2jYWLtNP7ldhsIeZUBPR+5+FUF+9W+G8VhvCgvLElHc83hcd9AsSQdB/nn9lbKM3pkSprV8=
X-Received: by 2002:a05:690c:dcd:b0:6bd:ed6c:b3c2 with SMTP id
 00721157ae682-6c628a9e8ddmr89979027b3.36.1724675690362; Mon, 26 Aug 2024
 05:34:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Mon, 26 Aug 2024 18:04:39 +0530
Message-ID: <CAHhAz+hjhZQnTWX088EmMDbszAJrrBQBqkhvfiMjxQPNtWbkqw@mail.gmail.com>
Subject: Query Regarding Stack-Out-of-Bounds Error
To: kernelnewbies <kernelnewbies@kernelnewbies.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear Linux Kernel Community,

I am writing to seek clarification on a potential stack-out-of-bounds
issue observed during the calls to for_each_set_bit function or
find_first_bit function, specifically in the following code snippet:

static struct cmd_info *find_cmd_entry_any_ring(struct intel_gvt *gvt,
               unsigned int opcode, int rings)
{
        struct cmd_info *info = NULL;
        unsigned int ring;
        ...
        for_each_set_bit(ring, (unsigned long *)&rings, I915_NUM_ENGINES) {

In the above code, a 32-bit integer pointer (rings) is being cast to a
64-bit unsigned long pointer, which leads to an extra 4 bytes being
accessed. This raises a concern regarding a stack-out-of-bounds bug.

My specific query is: While it is logically understandable that a
write operation involving these extra 4 bytes could cause a kernel
crash, in this case, it is a read operation that is occurring. Would
such a read operation still be capable of crashing the kernel or
resulting in unpredictable system behaviour? If so, could you please
explain how that would happen?

I appreciate your insights and look forward to your guidance on this issue.


-- 
Thanks,
Sekhar

