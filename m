Return-Path: <linux-kernel+bounces-239938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09415926703
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86498B2237B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D21849DF;
	Wed,  3 Jul 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbVyliTS"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97E17A920
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027410; cv=none; b=OxWBBjvxRMItljyplvViU4N082ruUIOg0FEkXV+MsQZKTj4pHhASO9BVlHwJbwcVzZVM6cuSh2GxbRJTuzjiFfpN+U5kY8kbpGUeSCqSkpGKONb2mTD0U9UvqTFI2sKdGnuJLMFH+yalk8ZBS9lnbQcjBVpCGGDl0znvjTQXc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027410; c=relaxed/simple;
	bh=9Qs5ol2ze5oiR2DbW9m/2gue58457PaRyAxDKiR93+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2B93R2cPwgCkypQv8e/QbfVAPw3Q3syaVplatZT3x/kNetueue4lYdQen4ArZ+eZFP38yYNhy2JvhDbAK334uCmPCR3JH6ZC7JevD9aRKC4yQXEXo1Og8aQwvTmZ9IA8KsO2eUwc5otDn02mPt5u+Atc+tpLdYVwWv5X5mIKYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbVyliTS; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-651815069f8so7776967b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720027408; x=1720632208; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti6v24oTe1MEKhNZLLn/dVPsQr2JQWNo5ls87iglapk=;
        b=GbVyliTSjri3Z8wDJnvtQpOKytk5jbQ0VqJHqZFPAHLIPjl9znCibr2/63VkyCp2AJ
         UJmORX/TNLyVRnYRX/SUJt4pS23iIHL5jia8sBnwHaREU2MdIAxx03jU/17zKBMqZ3Aj
         kJoI91/P1CnD7Wh4LVQg5OR3HdmQWTip55NlpEJxiwV1Xdz5S5fcCrJwlnYF3fsHeU7E
         4ncT/WghMvKAusuLNIiSsmL0tLcmhn0+wWPy+XbzrTbz/kdPFOvZ4ojjsrrNE4R2upUK
         GN546AFcnjgLWVOIKiIm1wbzgX3zaLLurOq4wNbV8+sO3vY+jWuJ+MgrtOaACi7ij846
         LnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027408; x=1720632208;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ti6v24oTe1MEKhNZLLn/dVPsQr2JQWNo5ls87iglapk=;
        b=diwpbN5sSVAX9AaYPIT79WlbjOjh+f8/wrLHGXALuws0wb6hn4a1G2x+vq4YfQMEz+
         FGHAXh2Hb2mWjeVB266N3MdDtRrF6rzkrt744nFJKIGsL4vEDIYLZClbUIRNQbIMVs6W
         Ow+Y04fyLBDBjDilu1vDj9C7OC5VMjI5kckLjUKASSFMiGkUY35JW+q/ZjLCZTtFVAwV
         UYTZzcrqajHFe0HBRNuJK7DM8bfyFxUjwaPQk6y+wiITKbhQ95xpTpTh9KWJARGr/MOK
         7Vafkh4HftIdPSjveSZmiUZ2l5ISSpRORwB16J8NouPLFieDRcxVXxnbFfu+KX+fmTW1
         mUpw==
X-Forwarded-Encrypted: i=1; AJvYcCVRr3zJQFs7Fi09RinA1JhKYoWr7xcnZl7C7f55cK9Qyh6qpJUouEY84/kSBcZ7YgOJ76Mn4sTWcVbEWsWOSLllLnzP0sXrljdKnDgG
X-Gm-Message-State: AOJu0YxZr+KfuDAAcJRWWNXERnW3dywpmu1wyk8ulB40y2Ohaj+HYsDu
	adlX56fZIdxhlrHDg1K/Zpyzb336PzweqHimBwVDMCHOKvyczWe2TQYy5XVCWeeGmrxCWncw1Xg
	5gVruEo536weeSTPFDaePxO/9w1m5Z2QREwM=
X-Google-Smtp-Source: AGHT+IFWOydMbN6BlWi7lFEJsFqVYPn/wQrhz+LemE/ooLfbb7YSNlm3inzv1ZHEE/FXcdtbKBxpbSiueYfE+CJjO98=
X-Received: by 2002:a0d:ebcb:0:b0:61a:e557:6ce1 with SMTP id
 00721157ae682-651800ecdddmr15155807b3.1.1720027408329; Wed, 03 Jul 2024
 10:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616203231.43724-1-av2082000@gmail.com> <d6cd7441-53f2-4c88-a361-729e3abe81c1@marliere.net>
 <CAPMW_r+sPGF5=+=edLY81X+Cd4bMWKFJw3sDd0mzaZEM9b75BQ@mail.gmail.com> <f64523f0-db39-4e3a-85a6-1a3cb07e2d08@marliere.net>
In-Reply-To: <f64523f0-db39-4e3a-85a6-1a3cb07e2d08@marliere.net>
From: Amit Vadhavana <av2082000@gmail.com>
Date: Wed, 3 Jul 2024 22:53:17 +0530
Message-ID: <CAPMW_rKV1BkBbrhcKNkMvhSatoHRNk58O8m8m8GHCN1Jb2V-8Q@mail.gmail.com>
Subject: Re: [PATCH v2] slimbus: Fix struct and documentation alignment in stream.c
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org, 
	linux-kernel@vger.kernel.org, rbmarliere@gmail.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 18:00, Ricardo B. Marliere <ricardo@marliere.net> wrote:
>
> Hi Amit,
>
> On 19 Jun 24 23:28, Amit Vadhavana wrote:
> > Hi Ricardo,
> >
> > I have rebuilt it again, and there are no any warnings or errors.
>
> Thanks for checking, FWIW:
>
> Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>
>
> BTW, I received this message plus another two empty ones. Please check
> your settings. Also, make sure not to top-post [1].
>
> Best regards,
> -       Ricardo.
>
>
> [1] https://en.wikipedia.org/wiki/Posting_style#Top-posting
>
>
>
> >
> > Thanks
> > Amit v

Hi Srinivas,

I hope you are well. I am following up on a patch I submitted on 19
Jun regarding a kernel document and Ricardo reviewed the patch.
I understand you have a busy schedule, but if you could find some time
to review the patch, I would greatly appreciate it.
Your feedback would be invaluable in helping to improve the quality of
this contribution.
If there are any changes needed or additional steps I should take,
please let me know.

Thanks
Amit V

