Return-Path: <linux-kernel+bounces-388136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236AC9B5B29
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 06:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B041C284194
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 05:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1ED199926;
	Wed, 30 Oct 2024 05:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8XnQ+1/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B1433E7;
	Wed, 30 Oct 2024 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265484; cv=none; b=Xaqxe3/+3zyocj5+JFWICJRLcvBf0tYZYoYBiEzGeI5dEdV6DQB8j70PDFYaOHf2gyARno3HUXasy5urrxXsPg5rz1KVZdZ+aL9H79SR5YRLiesVpcjfp8LlAsBpSLGs9gJ9/8kLXpcW1xjTACWoiJ99RorDgEIk5sbEKW0iMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265484; c=relaxed/simple;
	bh=24lXcsrnftnmOsMR79zaIp9ysIVZ8O9xPBJSn2Jr+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMAixjIQabYUq4SzVs/MnhcfESHGUmNquh6I7Ok4Q43p0pvOvX6k9te32nilZWoWid49yLFWzSE8sH0tj1iyGGMFtMWnsBkkPxSU9zxdT9/imJVoJR+SvPAuBe3UEyt0ZePflfUYW9Jsh8NkrS+F0lhZ1x02oxYgX+5FW/38pKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8XnQ+1/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso4813922a91.3;
        Tue, 29 Oct 2024 22:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730265482; x=1730870282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24lXcsrnftnmOsMR79zaIp9ysIVZ8O9xPBJSn2Jr+is=;
        b=O8XnQ+1/ukuvQP3EmxuzwtWVWIq3Hi5fG420UcNiY1DKaGvbSbcaa3xqvYHkiVTdQ9
         3MPTXgYnN3LuPuBnjdU9nwpPbqhddizYnFCY8U4kThMmnByX45Z8q1YMwulLKfrB8D56
         gZsfv/QYVu4a8j3kQx6WyGKsHjZDo2dAoDEBjcScyIJtVn755KEeWJrk6fIV6mYc74jN
         AlJgauGn6FiKOQLhIsJZUf/+NzBn5XeMpS/8+QurtAaNGZJpu+JJl8l+wReayng8lmgk
         oFyXqiRK+pvh6H+qJCD7w8ce0J3/Os02xqQhf26+F5cqIY1HyNqsehgo9en8/P2XGl1E
         CahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730265482; x=1730870282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24lXcsrnftnmOsMR79zaIp9ysIVZ8O9xPBJSn2Jr+is=;
        b=Th6/bnAJ+JEIO6A/sIieuGf3eI2GNH1oi3CiZRuqiLQHhPgBU4z7bYHEeXFvKa3iCv
         kKKXTaCLl89UzZt3pu9LFZ/fjZ7S3T3h8d1UC9AdzgHmkaow/NE5Rsu2lUpIcNWBvhdG
         tqidA4IejlEeTFwWDJ1/7+N/BnD1Y+MUwwpm8sMnKcx1A2R8+9kfV+0OxPk62b+sYxO3
         dO89cY88va6QwvNlz+6hLTnQPlBr4RrseMkMgd2Pv7vVe9p468n4IpSqOJlRsuyKQAXD
         tsaHzvanrtsQuRTkYKuCrHVE70a/mzGoWSmQ35f78VQl239r0m8EnS5ivq+gDENZ1L0c
         E6BA==
X-Forwarded-Encrypted: i=1; AJvYcCUV/yr7qQTCG66tewlqh3TPiYJUKLQaAK/Y8vGF1MzKIzve/1Y58e5qOyrIai7SwQqv0csaCGXDgxWPlN0=@vger.kernel.org, AJvYcCV5lzIy4piCN/RgSYgd8fnW8HDcQaQ0rYvFjW8OxyvCATlCnBZXoJWV5RQ4TZTxu8xPjIzfZhpFgJt+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZU7gVtZhpfvgrM+eGKb6BYWm19Lyv8GRaJyag9vvuwY6SmZe
	gpUkWjF9XUHsQ1vFxpsP+5D7YbqYtqCiCRr3808rLyDnSY4p6PncFP11W2hwIDDBo7xzKe90eht
	hyr1fWiGHKuHKwcqPNjQ+y1zQ+YxnyOUB
X-Google-Smtp-Source: AGHT+IEo3RLpfNdFjre93O+XF9fqC6nGsT2rG0gs8cMFUx0GjxYOtAcP1mK68iFwIsu4qooKb7XgcccUynR2hOHs+No=
X-Received: by 2002:a17:90b:1d91:b0:2e5:e269:1b5a with SMTP id
 98e67ed59e1d1-2e8f11e9145mr13693271a91.41.1730265481537; Tue, 29 Oct 2024
 22:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028025337.6372-6-ki.chiang65@gmail.com> <20241028105451.0e2e92a7@foxbook>
In-Reply-To: <20241028105451.0e2e92a7@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 30 Oct 2024 13:17:51 +0800
Message-ID: <CAHN5xi2XLnp+VhM-6QxWeMvZ_uQRSqaeHSqEjab+rSNZ9E98pw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] xhci: Correct handling of one-TRB isoc TD on Etron
 xHCI host
To: =?UTF-8?Q?Micha=C5=82_Pecio?= <michal.pecio@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, mathias.nyman@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

Micha=C5=82 Pecio <michal.pecio@gmail.com> =E6=96=BC 2024=E5=B9=B410=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi,
>
> That's a bug I'm familiar with.
>
> > Unplugging a USB3.0 webcam while streaming results in errors
> > like this
>
> Not only unplugging but also any random error due to EMI or bad cable.
>
> > If an error is detected while processing an one-TRB isoc TD,
> > the Etron xHC generates two transfer events for the TRB that
> > the error was detected on. The first event is "USB Transcation
> > Error", and the second event is "Success".
>
> IIRC, it wasn't just Transaction Errors but any sort of error, like
> Babble or Bandwidth Overrun. But not sure about Missed Service, etc.
>
> And IIRC I confirmed that it was *not* the case on Short Packet.

Yes, it is not.

>
> Also, I'm 99% sure the problem is not limited to one-TRB TDs, but
> it occurs every time there is an error on the last TRB of any TD.

Yes, this can happen, I didn't account for this scenario.

>
> > As a solution, we can set the flag after the first error event
> > and don't print the error message after the second event if the
> > flag is set.
>
> Yes, but I think it would be better to use error_mid_td instead of
> last_td_was_short, so that the TD is only freed on the final event,
> not on the first one.
>
> The spec is clear that we should only free TRBs when the xHC is done
> with them. Maybe it wouldn't be a problem in this case, and it surely
> wouldn't be worse than what happens with Etron today, but IMO it could
> be a real (even if rare) problem in other cases when this flag is used,
> so I would rather remove the flag and handle short packets as per spec.

Thank you for the explanation and suggestion. Maybe I should start
trying to use error_mid_td to solve this problem.

>
> Regards,
> Michal

Thanks,
Kuangyi Chiang

