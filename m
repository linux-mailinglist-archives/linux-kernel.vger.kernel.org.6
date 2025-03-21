Return-Path: <linux-kernel+bounces-571834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC2A6C2EE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F5A467FA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3322FADE;
	Fri, 21 Mar 2025 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="eLv4wdMf"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B2C86250
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742583681; cv=none; b=iQs47iWOB2p7e1JAQ+e3IKsiYkLUfHej50g3QP9gXhEpV7y2GjQAJ395yrzJ4cK1AgHKFkFF84JdRrli1CnBXvaabKWk/FcpnvW2YN5OtQ/T2pyOpldsd1a9goOrZIgb7OxRXDrawvqYt1Pd88eLju7dhmEnd3oqcm40Rm1//1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742583681; c=relaxed/simple;
	bh=Bd3W8zmoA56286TIT/M27tLloKuTGWvB4Py7sj3zCIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1o7awaESYSQ84KstybHZBqR3Uf6bK/cHuRyrSpjAsXLdVLTGQvyKmkSiu4T+3fzQ/7Q2a6wKc51VBBDdRyeyHbhszchs1Qktdl4GwUt46Z4fdiU6RScxwG+7A2qkE71KO+aumfjoRG+HBMf8Rtb0OW9mgBg0jVabIAYNN7bJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=eLv4wdMf; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fee50bfea5so20372707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742583677; x=1743188477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nR4lHmAwKxP9HyGmUTHKde+Eo7V+LJcGUFHENv86AZM=;
        b=eLv4wdMfCHT/qkHUpHNYlTw9jw8y4tRKA50OqcnETlj1Xw8TQg3iHhWwCPGUObTfCW
         r5Q6cglKfIQ72iTFTlc2BVA+AvqPUg8k6lriJTrNxpAtslDQCZyqDSeJP+RrX7xdtSOH
         Ro1oQGndRZX/yrNrJADmrglm2vvjyifldVsYCICkoJ/fRnqg+dKSCIOMoV1U/vPS52rE
         ODrZKcHsTd/Abj05vJn0ZUe7/gzwMRti3hWdSv92WFYeeto84MhcytkbZd43dFEmUGwT
         8ZzcD+bgu2Oa9g4aVYOdt42b/2W5rj/lzHglevYdrsrhCKQU1HUQXrEwIpzObVmrtzQw
         izhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742583677; x=1743188477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nR4lHmAwKxP9HyGmUTHKde+Eo7V+LJcGUFHENv86AZM=;
        b=oJByM8IirPOLuDmHMhoFdqFoZQ/Gvd+ZG3c9aTd26Owb+vK4U9Bf8SE9DJm5FuNKMN
         0OtqG4sic/gwnN4A/pFhfr+xwGVTfdDSa324d2b9LBxaDNoWiKoDVM69KQZlhZ9hlwEC
         NpAcdPV2Fr95Uk0JXVrCkXeYL/7iHYhJQhKELayX2wecbdRY3mzadX4WstN1Di/0AvgW
         VMekOU55uwkiTUTbRGp0lt1vHDvxyquqaBXYZOL/DAgouvA6KP84g9Yxm2FLeAHOlU2g
         WwDYSiftLphK8JpCEasvdgqvCg9jLIwi7Og0vyXSqad4cedpqMuX430/EuUn8tBocxkW
         ZEGw==
X-Forwarded-Encrypted: i=1; AJvYcCUNkS9CCwxrXpFy3pGQnaD8cx6nEHbMOHbQU6ubZFcjSQOAwhBzyWRfph2mc3FBfsOjj6tXrnTzJSoPyYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUos956/5XqI/DMm6MJ7sjXIjTm2B8/vw8x6Hd0wfEyPhp3Fst
	u1eAKN0cHoLNwiPD926HBUvx1112OlA5u+L4mf6XPMcK32a/hirUlBlvM8UdnOY=
X-Gm-Gg: ASbGncs07L8H/tmckCFmtQA2LFzG0SQIcdcxZl83hraclky7DYDgKIctVBUWOXR4e2V
	BFqckzhuu9ZtsOnvL6hVbt1tBGjOIujZ2vMG2VDjaW7Id7UKrrZSQ2mYcLv571F04F/xrrtqRQd
	uwQccKDhmODeblQ78qADA8A1MSY26gYSpuz7C1lW93a6bj+J+gmDY8Ox3t7yyKrGT7RglrX5QA6
	YuVkBGdeqzGWtlMsWLbgqCbG3ZUU1AOGC3qsDSiifEUDjPME2pw0uMPEV/+ERGPKDZJksx1TK8b
	D6fY8JYbBq9TkIXXFWd/ZcbFgDskXFk5hzP9bh/4uGaUBvNYwOnmWVpmzGbkXqAYaUHpwT4NOks
	0VuKt8kiMitql9xjUBggJEYkmLDM0TA==
X-Google-Smtp-Source: AGHT+IFCFymzOe+88jvBtqQf3WoNAsE5w0tNrMWd418HpWND6k2Tz7c1vpjL/c8frjfQ1C9HkTGr4Q==
X-Received: by 2002:a05:690c:3391:b0:6ef:7dde:bdef with SMTP id 00721157ae682-700bacd6b69mr56614167b3.23.1742583677457;
        Fri, 21 Mar 2025 12:01:17 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-700ba73b9adsm4773737b3.20.2025.03.21.12.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:01:17 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brendan.higgins@linux.dev,
	contact@antoniohickey.com,
	contact@byte-forge.io,
	dakr@kernel.org,
	davidgow@google.com,
	gary@garyguo.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ojeda@kernel.org,
	rmoar@google.com,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
Date: Fri, 21 Mar 2025 15:01:03 -0400
Message-ID: <20250321190103.1778248-1-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
References: <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Mar 21, 2025 at 10:06:03AM -0700, Boqun Feng wrote:
> On Fri, Mar 21, 2025 at 10:28:06AM +0800, David Gow wrote:
> [...]
> > > Anyway, KUnit `#[test]`s are in -- I was not planning to merge this
> > > now anyway, it should be reviewed a bit more.
> > 
> 
> I agree this whole series should wait a bit, but do we want to merge
> patch #1 as early as possible (maybe right after v6.15-rc1), so that new
> code can switch to &raw since that's the direction anyway?

This would make the most sense to me, it would keep things clippy clean
while also allowing new patches to use the feature. This would also
potentially help reduce the amount of refactoring my patch series will 
have to do as it's delayed. 

Thanks,
Antonio

> 
> Regards,
> Boqun
> 
> > Excellent! I'll make sure to review the new version of the patch when
> > it's rebased.
> > 
> > Cheers,
> > -- David
> 
>

