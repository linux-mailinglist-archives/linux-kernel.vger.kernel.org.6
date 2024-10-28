Return-Path: <linux-kernel+bounces-386053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814FE9B3E91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 00:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35E51C216D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6E11FAF17;
	Mon, 28 Oct 2024 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzARo+yB"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD71925B3;
	Mon, 28 Oct 2024 23:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158777; cv=none; b=NuhgKxaU92G7B0DmdWnWZ05gZ1hDb0CwCqTEfmgdCoy/hVRv4KHtPUZXhKIciV82lMbobMMOUZSOWgC8I2EJkRjZAXEena7/mTCUcfa82ja1nv1Po7snfeSwWIS4pVSuJYO0+HaxF4xnqi4N8jwYnl+k/DBAw+dUAnChQGV6VY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158777; c=relaxed/simple;
	bh=p9sbYlGpH3XUnagoxF6Lm23DhMEM9LNRWZRCK2y9F6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAy9xyZW1Lg3/4Qi3i8fPp0TDLFSTSiN5N1gV5ZLGotBXl0nKLOJJlcG1j770c9lBMKBLBNEzWIkIk0Yqf2x21ezLbMZtS2WPWNb+CSznJHNZaftIwliYZmD9XljFR5D+22uRPmCpa5vn+8ShG07xN1tR7f+qCDhf+4+jU/pMiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzARo+yB; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so3874854a91.1;
        Mon, 28 Oct 2024 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730158775; x=1730763575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7DyiDjyvXKkTuu2TcoYINH5EQOQB3jH39wxFxqTGVo=;
        b=BzARo+yBy4NdZyIH1mnZa42WjPdWo8prRdhw8VqliFU/83ESHkV3H97qiD6S+/xw3L
         qr1lIXoIzbeOnpdhfHjvWRQaS+oZRl75QAx6J3+UzYBsCXMVKiuf7ZYylB2CxDVYkVcs
         mDyYd+WLQnmy5l1R4+DZ/xi5EeFvTUB8uuev2g5emD7PP9Ig786fEUZ2iWohYsEHbCc+
         +/x2CNlevIKAr/7b+40LlDmXAXIfTV7Ue+HTUDpuCtZ+F4b4L4AtFTtTi+baPqMg93+k
         vY8Qn0ua3JyW6ghkHlwMfw1SW20r+VoYGgkpYLBB+97KL3/xZKnHfnZCOjNb5UA3Vved
         /Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730158775; x=1730763575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7DyiDjyvXKkTuu2TcoYINH5EQOQB3jH39wxFxqTGVo=;
        b=lopnKKV6pIpKxWUp9qMvwBryCf5yeE3G/Bxas9+f4aG8GGGhNZvbjIPkCklQa01sSc
         s6yvdk0yvaxJUdedmqQ3HPbmSnIn9lqcKl+ajI+2VpXQy1l2L33pyDbiOnNKEta8xDqX
         ev1BvzuoLdZsjLY4x6NAl+J+RGnjQ3fIMYguT0EPkwjZqHueDpBxSHQYov77749FLAP9
         u3bfX9kUBi6aNDUWXgsGsiCCRkLb9aYNyUVC18tm1cx/vv8wAG2y/R4HgrIRxf60FEeG
         e5qIhtHyVYGdzSzbXuyyqNdXgQNYwCIMw9S+WALUbKh8o6ItwtB3SmFJgxBFQE+dI3OL
         qy0g==
X-Forwarded-Encrypted: i=1; AJvYcCV4H392Tzu1LQzi0cptjHxh6ZE43qJczSDfRccuRwnw+951yIjmf9II9246uPLxNuusbavbBCjliSuK@vger.kernel.org, AJvYcCVA8CaqFPehRkOm5CJUJNY3HSO2YIA8QRl9DFCQcVTGeHvjMHDlcJEKmLsAB6u+1PGwfSe/6uY1YLW110n0@vger.kernel.org
X-Gm-Message-State: AOJu0YzAumc3Fy9PlqSzZkNPPINSRwhT9AvcloMtZNz0AhaF/XhMHusz
	2bWy9B7RxcooH383rStpUBfb3HQsyveryynCU6BW6j+5aI/itV72
X-Google-Smtp-Source: AGHT+IEfhvwRKDrINSpj1Q3RCdtGX1BnVmQiUxZygsBUZVuGX/l68vRcrLgWoyyDQ62Y5H8AfjxL8g==
X-Received: by 2002:a17:90a:ec12:b0:2e2:cfef:86 with SMTP id 98e67ed59e1d1-2e8f104f0b1mr12631047a91.4.1730158774747;
        Mon, 28 Oct 2024 16:39:34 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e59d826sm9925575a91.52.2024.10.28.16.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 16:39:34 -0700 (PDT)
Date: Tue, 29 Oct 2024 07:39:09 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>
Subject: Re: [PATCH] riscv: dts: sophgo: fix pinctrl base-address
Message-ID: <a3licezlakpgqsvi65i44wbndvt7y3jalbebuxevuz57ctj6ox@aovdt36w7yeg>
References: <20241028-fix-address-v1-1-dcbe21e59ccf@bootlin.com>
 <MA0P287MB282284A77094A096573A23F2FE4A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MA0P287MB282284A77094A096573A23F2FE4A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>

On Tue, Oct 29, 2024 at 07:34:41AM +0800, Chen Wang wrote:
> Hello~, Thomas
> 
> This problem is introduced by this patchset [1], which is still on the
> sophgo/for-next branch and has not been submitted to the main line. So I
> think the right thing to do is to submit another version v6 with your
> bugfix.
> 

It is OK to let this patch go. If we want to keep the patch persisent,
it is better to apply a fix than revoke the fault one and apply a new
version.

Regards,
Inochi

