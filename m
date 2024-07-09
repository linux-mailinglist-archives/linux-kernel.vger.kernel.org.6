Return-Path: <linux-kernel+bounces-245353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C9B92B199
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 491C7280E4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C31514E9;
	Tue,  9 Jul 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc1kcQQu"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B1C14F9E7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511520; cv=none; b=sMeRiWvJ4/YLAR7Z/CvAG0uECEFNK3fZwpS4z/Un1CVOn259AOo/pY2kw38EZ6viIzwRjJMj7yzOANBSsLqtr6QTldKeRRspD7yJQrWYqhCUBPbXUEtcgTgc6dyx5EFZJz5z7zpiEUEcYH9k/2s/Zocz0bODReTYGvAV/Fbghj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511520; c=relaxed/simple;
	bh=vtDq6fhJrHidB9Dg1wVKS8PZ9ZuHsRfC6K0YEQDOvjM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gEF/OsHydpN2r1ABNjo0RH4dqvtHRPT2hfkQADXSmAmzxjTZR6gR7TYU4rcMcnLvYON+d8OkJxn8JF1r9T2tWSpD9EL4Xi9CQpGj7pvcUx4dTrrkDWiEmpN8TjY3k2tjW0eBc5Et+mvD5ktUXwiTv0rZ9uI915Aw9XnMn9d4ia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc1kcQQu; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ea34ffcdaso4525928e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 00:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720511516; x=1721116316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HiGTl371pB8HxBA2dvmd2neCgFR9EDcWkDgu5gr4nKM=;
        b=Rc1kcQQuwVt7Ka8Q+tW29pV/rvArgH8Ej71upge9cbX1HZU0WUF9e50W7D2R6L0KrG
         Rxt9HUUwu82BJQI9oAyBX2LWOm4ixCB0/tFG2zgXSvDRYJX+1Uiv7htwF4F1GbR3ubBf
         6VaUpymOWE3VDVRs0dB6Gq6jdkaneqsygCCJEQXIXvHR8H7zsevnud8csgaMhSo2C7Jw
         GiaUDozLVIE+zJXV+8BlBd+hy5RlXIfTryzBdg1wJpNSDsCsKphruvN/Q77zr3g2gzk8
         TNZDcDggnOAF6ogIK8hsu5BJLiFSEYh/Ufz0sz/6bXBXGoMSnT8T6NkO36UeDlm8YVah
         gHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720511516; x=1721116316;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiGTl371pB8HxBA2dvmd2neCgFR9EDcWkDgu5gr4nKM=;
        b=pLDm8tVlAuhHqMX2uPv1GGLB3EJwT7e5m/trBisVqVzktlEz7XrqQns0zMcWLYTUYa
         JMCb/tQShdBIjWuZy7kd61J+iQAlAGNre0toOlkEmloFUTREvFll9sUnkaXPww3E9ySw
         9527U3Qww+BWYEtIzhBzkTCPB0g03pCMtNZFUr2lZqIXl3GlU6oq/j8lxdKKtVbEpAQp
         gJw/Ik30SLZMZzcWuVPMrXYje9RPqopqU95z5NIOsNtLrckdOGcn2OvJzE2QO45z75nj
         eh5txOf/uBOP51iAsUE5jMFBeGdQqqVfAU+FGCR9GRDOX5BvE+CO08HyzSTiIEl35aK5
         Flig==
X-Gm-Message-State: AOJu0YyAjxtfaPhgEouQkwEFRQznPa2D3AgtCuT6FWtEhl5Y0208Ei4F
	uId8SQPhZsgXdwQ5eRk/FhF3gjGqx2oPrsMjOvxB9BtP1JkPWgWIJmF1ZmzgNh1TvoJwFFAdCJR
	CRtY44ODOl92hJvRp/ffWRpvkafnUaTki4zsPxg==
X-Google-Smtp-Source: AGHT+IFhEt64afe6A6YzOnm4ZktfgXt/TDMVHieWXg+2XSC0gYhF3ub54lk303xEn2cR/uL0NMSmuFK28tKELaW+Sfc=
X-Received: by 2002:a05:6512:114d:b0:52c:dbee:bdb0 with SMTP id
 2adb3069b0e04-52eb99d4e86mr1137251e87.59.1720511515965; Tue, 09 Jul 2024
 00:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Shanavas.K.S" <shanavasks@gmail.com>
Date: Tue, 9 Jul 2024 13:21:44 +0530
Message-ID: <CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com>
Subject: intel CPU vulnerability NO_SSB whitelist for AIRMONT
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,
This is in reference to
https://github.com/torvalds/linux/blame/master/arch/x86/kernel/cpu/common.c#L1169.
The whitelist for INTEL_ATOM_AIRMONT has NO_SSB enabled  which means
cache speculation vulnerability(spectre 4,CVE-2018-3639) is not
applicable to  this processor. But NO_SSB is not set for
INTEL_ATOM_AIRMONT_NP and INTEL_ATOM_AIRMONT_MID. Are these settings
missing for AIRMONT_NP and AIRMONT_MID or is there a real difference
between cache speculation between these processors?

regards
Shanavas

