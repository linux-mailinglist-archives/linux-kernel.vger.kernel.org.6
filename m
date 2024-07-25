Return-Path: <linux-kernel+bounces-262515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA9093C81A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A9B1F22885
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEF19DF95;
	Thu, 25 Jul 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtTULnQv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26619D096
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930704; cv=none; b=j75UrUe5O2iT7R9w/Q2La8GWJ1Zxzk2q76K7cOaiiOtBABB2Eiy2853qOkRpKOtwVqeysllcL/gTqqdt5g6uPPyCEfVjzpDZ02FllQN0FIBDnYvgpKSN5dETXTGeKKMU2sQ0fRR5YU0GSYJoa1OJUhuQkONLGR9U4DhNawKMtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930704; c=relaxed/simple;
	bh=Ln7pIROyNL2e8TY7o37HN9wu2DLQeir/eCYn6K2E4vM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjnqTarbOWSSmarDmRgqEDqBjTC/ViJ1onPRR4F91jwQou62iosgA9nMvidTYhSMqQ1xnurT2g0YyoXZmfKzQ9OaOztvifVH0srSZVVBmgw760DydKAGdGtA7T1MslShU2eM9bYf7/OQVKZHxT/8ZAIEyk32ZCFnva3NDYJkJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtTULnQv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso1774a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721930701; x=1722535501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln7pIROyNL2e8TY7o37HN9wu2DLQeir/eCYn6K2E4vM=;
        b=UtTULnQvUOD0Fo1+T/GeCLOLiplhxTHB6k2yLthRx2aP8EUbLKzt3vk5D15onHABqP
         o3yAeuNTXd4hugOqyGrUvbE5ibf8kBoDIfsrZOQKzQRU7BgVy4HoYR6qQCTyAfUqezup
         fQHEay3E5lCOn5ncN3YYeAuKn3OX0EPS1Q4n3TBxm533VjvbNdUWM3J/TI9JPs/QJH7o
         TJYu93sKg1/IJUDR+B6KNiUXNggjhIrHVaK+SuMUeIa77/3RzeMzDh94tXqjsAcgV7s1
         0LwZXBCpb0ij97jtIMIJPaGYFK4J6L2AaiS7esP+LHAWOaUFDhzQQPDsDveUbzPfFMQB
         ZD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930701; x=1722535501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln7pIROyNL2e8TY7o37HN9wu2DLQeir/eCYn6K2E4vM=;
        b=vxa0wfG6I1rf65iDqYlUru5mPCjatqTyOw1XNOeH29XBshzIooexBGLRoy9oZSbx1P
         g/8nnoVoRrcGCsVbampxpJO6Iyn2YwLIXYkdWcF9aFjorFRwqFAQBxxSUHQtW8B0WxdX
         lFK1giLB8430DfM8nhSV8ytafrKfgCCwYL30E/YQvx32iiOiQcr0m73UvADSDMQUI1yk
         5w9mwHD/lAJvKvzsKhAAenCFXutt5/PYyjzKBQjkHFiL87m3ZX22RXY+Um+3a21nmUNb
         ht4GmPmsKuic6pquPOpAKEGj+VoTZxj24QoBLw9g1QaPtmXgmDgeVV6qAlq/TFgtj2nb
         Q/sA==
X-Forwarded-Encrypted: i=1; AJvYcCXr9iS7sPNPf8TMFWwJFoMnCeiUbhSo3IYQsFlg7uaK7egxUgkm4l+C3s+BTWvF1OvoFWJ3wlntS6/y4R6NgKO3tSGhoexVqiLdHbi2
X-Gm-Message-State: AOJu0YwPWqBryD+wfY9p53I22VwSdrsSOVmL58kE6SWapz1u0G4aEoJ3
	hBkL8m3nzTRVikmtPS9N+oobYoTWnoAff31H9PgsB7HUfEoddBcIfjhrPVNbhB3w3L3nYW66eM8
	wGlzhssQu9IU4LVPI9YroT7HRQfk4JGj402uT
X-Google-Smtp-Source: AGHT+IH8z4Za+6/Z1B3IgbuCXB4JfXr5uheGGyEvuz26GVQ/eQTwpwOYNTdFjUmLYinEclswXmKwzqx6F2YxY0PjYVM=
X-Received: by 2002:a05:6402:350e:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5aed9954919mr7438a12.1.1721930701060; Thu, 25 Jul 2024 11:05:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724201116.2094059-1-jthies@google.com> <20240724201116.2094059-5-jthies@google.com>
 <qjtutodlbqhsj3ofdhhw2ggjgh3sqglvxmxt72oz3j3xsswmau@g4b5ub56ctfl>
In-Reply-To: <qjtutodlbqhsj3ofdhhw2ggjgh3sqglvxmxt72oz3j3xsswmau@g4b5ub56ctfl>
From: Jameson Thies <jthies@google.com>
Date: Thu, 25 Jul 2024 11:04:48 -0700
Message-ID: <CAMFSAReWroteo9+1K_vFWsfShONyakr_LzxwVsyuBLCaUg2wbQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] usb: typec: ucsi: Fix SET_PDR typo in UCSI header file
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org, 
	fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, hdegoede@redhat.com, 
	neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,
thanks for the heads up. I'll move this to the front of the series in v3.

Thanks,
Jameson

