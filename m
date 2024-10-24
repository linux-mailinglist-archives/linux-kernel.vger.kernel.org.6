Return-Path: <linux-kernel+bounces-380763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78EE9AF5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C84F282D86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA6E208968;
	Thu, 24 Oct 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uA8s2lPt"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596114F9FD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811276; cv=none; b=M8W+Qs/2YlCnWnztTzc8hckkBqh82QpPI/hTxKfyqU6kpbLZgmDUGk9CWfJoYAOlIj+rguOtrt5bA0ClcoEANXuicmQw5nBFyC145ulG4qk0rMPl/HQTG06W4yG/g9IPiA2+PB2t+XGUsMuyIQnNmEWgN5AIRoZycX0DWCBGCWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811276; c=relaxed/simple;
	bh=DVn+SYk+Tjqw0iTy0Q3POl4+sdohk99Vj0R+qOJJ1tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU1sl0/8+28VJEe63L/PeBBfpHQcFQ2fkM0gjcIwNjZ4PPfmw76vncbvoVc61rHzbSQubNNWF0k6dkkyBCsrwox+NHPu8FDFld8az6BV+vap/S69WneS20JwXz+P2u3xIjviSA4EEh+47xRCrbyQ+PS7VL6HD6LrQWEAB/rnITY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uA8s2lPt; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e3cdbc25a0so18732877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729811274; x=1730416074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zd00M3Nfh2EArviVNHmKQJ9PrDOqZudLClGyoklHFFQ=;
        b=uA8s2lPtt7CxA1RbthIpkzDUNyv8+xp6VAIABipueeeNxC49n7DiDQlYdmpW/jQheT
         XpgduRJv/LUJ8+WGRm22rGeF4FypzLWm5kF3Mbb9tGF70QsASoir/Zh2/W8jSXmBbGQ3
         h9IokpTySpYxui+ifwUdnndnTJWlBLoXZC+/djWW3CVFDIHXhaE4/kSivJth+Fe08PHP
         4N96iX4rhv7RVu7X3JReUivnqux+tYtJENx72pvN6QZqh5GNl4N6v/p1XXEYFjVLxfIw
         2k2xoyIn1QGXR5imCtSmsQ7gkUlfX0xD5pZJoqetC2gxYXYVp6M2zImjabpW/yum/TII
         uIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729811274; x=1730416074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zd00M3Nfh2EArviVNHmKQJ9PrDOqZudLClGyoklHFFQ=;
        b=FtOUdEpMGFkwhgJUKtBl2dDUxuYIpgPnjRnu39gesTB9lCVpxVliazPmeo8SERQScn
         ulqk6M0o9PktTm1F3fNR4AZGDw2o6JgBEDgMGCIFg5i7GENmNLG292mXCf/GQJa/L9Jx
         ulLyvIHCk6Y1xfXzLziViXfpk8gCY0o4+6W+5tMvEjNkL0Jef+C/KD5jrI8j1/fU070G
         G7MXpEFeaZxs4ZK7hj3hAQtPoQDZ8J5cS683ASGsuuR8PS4XJhZYeWcPyK45WRwiZmyQ
         6+sEU8xjia+y+0jAilQShaxEXoA/2AjNKl+ey3vjAr9BKRtyo+8A6XsBKl3Q9cuSmVy2
         pVVA==
X-Forwarded-Encrypted: i=1; AJvYcCXDJQeKiXz4e63bwPRR+6jaBPCPGheEKn91icF2nTiMeI6tsmgd6DozY5mcyEVgnykOpAJVPlpTVxKeaA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXM5p9x4W2mHPCU7aRE1+LOy9p1DZLDrgds+aPP6sqAH16nxHi
	vFZcU0r2gFyjdDpEM7h0HD5Ir3+2FPkVW90sFAVUrBy6DLbYDx3dT8k0DlyzkCGdCkRmJZC0YAO
	U8nxiXwCGx1sPpkIzA0esq5yjgG5CwXTdMIkdDQ==
X-Google-Smtp-Source: AGHT+IF814lTmaAdxP7QG+WjWHddmoT0eNmGaeikt22gW0jXgl1lCMcHZj3wSxBIOfK0gG522vtucnFBiJQutSiPhTA=
X-Received: by 2002:a05:690c:93:b0:6c3:7d68:b400 with SMTP id
 00721157ae682-6e7f0e3e428mr83305447b3.10.1729811273927; Thu, 24 Oct 2024
 16:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com> <20241023213134.GC3736641@google.com>
In-Reply-To: <20241023213134.GC3736641@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 01:07:18 +0200
Message-ID: <CAPDyKFo05Hyw9gdEBx7zQq_6P58ittHHsZQLuqmeR1AChyHSHw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>, Eric Biggers <ebiggers@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_neersoni@quicinc.com, quic_gaurkash@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 23:31, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sun, Oct 06, 2024 at 07:25:28PM +0530, Seshu Madhavi Puppala wrote:
> > Crypto reprogram all keys is called for each MMC runtime
> > suspend/resume in current upstream design.
>
> Is that correct?  I thought that similar to what is done for UFS, the key
> reprogramming happens only after the MMC controller is reset.  I thought that is
> different from a runtime suspend.

Looks like Seshu is not really worried about the host's runtime
suspend, but the card's runtime suspend.

Perhaps there are some out of tree code involved here that makes use
of MMC_CAP_AGGRESSIVE_PM, which is what allows the card to be runtime
suspended?

>
> If it's in fact triggering more often, maybe that is what needs to be fixed?

We could extend the runtime PM autosusend timeout for the card, if
that makes sense.

Kind regards
Uffe

