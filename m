Return-Path: <linux-kernel+bounces-226716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC89142AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6316EB23956
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F8622EE8;
	Mon, 24 Jun 2024 06:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqwaS42x"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3518B219E2;
	Mon, 24 Jun 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210127; cv=none; b=bbeUkpntB3Oz4As51UKjTszxolRh1CF4gO99ZiNBYyMIDBDLuWUMpKKfaZ64RZnWTXcLsFktP2ewdAJF9OoCezIOAEoICHri3wm4/eGXvoc+h2coGCW07uGGFMKjJZ4PfmTsncTCVJp4p0+sCzFztYsJ2C/ZLWNSYZNl5rU9ELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210127; c=relaxed/simple;
	bh=izV8xtFw87LJRHc0H3NGdhgh/pXNsAOWlHQntv9q9Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VpDRGY7QSa2YOArwQUVoxxL8Zs1yNfyr71ydUN5kQ/OcnFkPNos+Ib9pNKd0XP4AgW/TmaxTVu++Pvhi5mvCcbnr8+04ovGFMFbf6M/UH5m3zzIBbW8AusjjLPNcMFpFIxCVVOMJd0DzyZPGELMe4+t7kzFYM43Sra6np1QOP7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqwaS42x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7252bfe773so59306166b.1;
        Sun, 23 Jun 2024 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719210124; x=1719814924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=izV8xtFw87LJRHc0H3NGdhgh/pXNsAOWlHQntv9q9Z4=;
        b=JqwaS42xSuYoGivGftta04s4VFAatPrxAo5jiYpsSi7FHnOZXUmbTXH1jSQvqFFzv7
         Qef+USwCHAWdNm1mt7GMUqKCJGL/x7beQ7cQyn9e1yMX1GWrw+J5OeF+O8LBvlAXq6df
         fPEgrmYLFTbaaFMFracqzy8JJaygOXkIE0X2koYFZufmfJ5staZlh+zLc+Qu7dnJU8uO
         ufP2+Ogn82ztrosvFBT07mBFQ3DEwnXJmb8Av3GKbbpv3agkVe0nfNfiuTYTsmIHSBog
         H3L6KQGCKmdullrjU7alw/FRV+/2TF78jfAvLp2u2Z48Ah/Y0Dgbgg+W0TAiLbucBU4h
         LbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719210124; x=1719814924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izV8xtFw87LJRHc0H3NGdhgh/pXNsAOWlHQntv9q9Z4=;
        b=Tij9ddPUJX4bFzHqP3wB+47EWijJ4O8ekgypUaLpGSJue0wgGFa2ry7oN3T6GeN/tH
         PgKToO77pvpXWVvTR7Bo7XZdArqjF108soI+lZ6Nb6bhliiLwaru56hHb3nihmS6eDCu
         qri+B7e8BGsdOn2Mb8cNxicbkI0VvcWDDgvlAArMsAKO/avKA1fOr3NV+CWsROX/skzM
         ZTAfKbzNUPTktU3C/I5ivh6WBaOTadkIO8xxSuclbKPi5nKkqI8Lb6P0k9DN0yvZSC2c
         xTivstHZTtQx1YGWoXs2hn+Vh2KaW21kHWMwEa7HsG7JGayCIbWrWuTtqLVaAExPOuG3
         Qt3g==
X-Forwarded-Encrypted: i=1; AJvYcCV92U0pmxXXrIwpij6doHpF6xRUevqAfhqO2alY53xkfa/3FE3QbqQ4cAIZRKZOX0IZ2FFnUG77y2H8Ll703PwtPTDhba2TsGQsm+Em/YYzUsjKw8c4V1avIJbdliMZjl4jbuyFoDKOmzs2gvhR
X-Gm-Message-State: AOJu0YwkInhSbhisJIWbSvABNdRC9IIhIx7j4QUiBIVlGACY8fuZP6ux
	slwI8KsP5mVXhRdNMOGsFVFtmWSxPbWSVjV992fG4SpdNDQb+ac52g8EOsQg6DuN+SY8HIuyjsC
	UNjhglgerQyD//+Gq7Dnbc+zsVI0=
X-Google-Smtp-Source: AGHT+IF4p3kQuq5bMoS6IT8dI6Brsx4Molp0hz/DWisb09x1f9QYxKJIHq/2rFVb9+bLYmidFi0EDdziT1pi0FXCcqc=
X-Received: by 2002:a17:906:f851:b0:a6f:5091:467b with SMTP id
 a640c23a62f3a-a7245cf27e8mr209723366b.39.1719210124278; Sun, 23 Jun 2024
 23:22:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603-md-agp-v1-1-9a1582114ced@quicinc.com> <650386f8-16c4-4988-b05c-1e4fc1c9167a@quicinc.com>
In-Reply-To: <650386f8-16c4-4988-b05c-1e4fc1c9167a@quicinc.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 24 Jun 2024 16:21:52 +1000
Message-ID: <CAPM=9tyKZKPo-bkhGFvwNTOaojV033j0S-5ex5FPmY766x4ocA@mail.gmail.com>
Subject: Re: [PATCH] agp: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Following up to see if anything else is needed from me.
> Hoping to see this in linux-next :)

I just pushed this into drm-next.

Thanks,
Dave.

