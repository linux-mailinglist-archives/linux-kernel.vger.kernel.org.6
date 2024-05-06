Return-Path: <linux-kernel+bounces-170475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A58BD7AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A37E1C22148
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDD158DD3;
	Mon,  6 May 2024 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsBoRsqr"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA89257D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715035648; cv=none; b=u8Vm6aAlf/INLWiJZ/L3oRLNW/fDBg0nizA+jAu2LewuJpZx1qMUZwvFTZRDh1Hltkfklub2EzkWw6ryk8dpfeB21QNzHC5GwwHz9JFAAHafXQs6uQAAvbBoh64dPwPCy4BE6GAfEOKffuop79/mlSRJp4IJe3I2wCjhKMKqC/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715035648; c=relaxed/simple;
	bh=xah3eiBvt2IRFNfHQzMpUEiliy3kzKTT1T5VLMfv/Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUlI3I2wwgxLFmvO4LJfZPWzQfFpN8tcBvqNKBMgVb/FfJY4RVVM7t3kjyovGAxvE+w69jy0gOYCqN5mbD1IbEW9EQnpxeca4f5rdrheAqCxZQuxaxzQGzO5MoXtmuruSXplavWDdXAbKnFHFmYvtghbEFA3S/Vzv1NkQTrx2U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsBoRsqr; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de61424f478so2658755276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715035646; x=1715640446; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I5ntu6mt3uy8mRpEVTg+tphF2bUMaNINXCqe+HKq8KM=;
        b=EsBoRsqrR2gbFUuPt38aOteas1830yuQoDjXNVWUM7L+T4qFDgbcJpqo5dK6gzWFCz
         gNpP7mIS8S/P4/yEnoew5pHGc2WVC7yOj4D9fpwQvfQ4+0SrnXtVGSKcltJFc7tHiq0z
         geH3VbIQJZAhKc8GXaxwniBeLq5tJPupXrlFE9S3oN9G84bU4Ii5Un0P64fVfjXk32Lm
         3Usrd5ujLBHykSfCR+JLnd6VuEsWFNW1sxCU7/eVHMefXyhlHfu9w3gFUlBgsJyA+tsS
         0YNHGPFeb2c0XE8CO3Md8khWknUBJtLQ9HzpHLaGHGq1f1utX6JI9v7t/PuOD1TLTfw5
         gn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715035646; x=1715640446;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I5ntu6mt3uy8mRpEVTg+tphF2bUMaNINXCqe+HKq8KM=;
        b=Laj4OEGHbEXd3E76wUkWYyDb/IpwbJdNOokzfViOcvFnFDQ3c/UDfByLbwfGQP9Uak
         wTVtbrPPDd8wjxy9v3D0dEjUMw+TeCa0ZEInXirYe48RqRkfwBUAglxE+/vD1LQsDFSb
         l5bZ7cdBvTf4k6X7m8rr5Ttao2o2rUvzSI2Fy1cK5dO4874ijXDyLJDIYrHjUbI708fb
         sEtdYMso7seY/aYjulEsE70Q3/pKZdimGIWueXlaJPpOLRLaTFp1n+/kN5dCchCigZhj
         fDGVaMsOP8wpU0A8UiTq+GehqGKxnJfaKlwgZO1E40Coj/h4gSK9uQVIUKibPeokGMCz
         s1zw==
X-Forwarded-Encrypted: i=1; AJvYcCWUjPVTZcMczfJ85sC3sA6iRWJLLLVv7CZqoD9NB3YHVUxwDyDeEuMVAUtFzu06FRb8sO8/MDQHOMsk08HKeYfT2mnuFkldU2THGAqZ
X-Gm-Message-State: AOJu0YyKI0oFU5FB3YEAyw6J9bt7QoztY7iY3YvrBoIa0uxVw/339qDg
	YYyRbEBcFn3J7iKYhZ3JvgKN2tAh4p6zwvjLUYaI421x1Xbn9AuE
X-Google-Smtp-Source: AGHT+IHUc8DBtbV67fJZi8Y9NrtxoyRynSWwehFJo41jBgIVvNSLEa4TEj4bLVyJeXx9xajuAs55GA==
X-Received: by 2002:a25:d0d8:0:b0:de5:f817:abe9 with SMTP id h207-20020a25d0d8000000b00de5f817abe9mr12081469ybg.51.1715035645741;
        Mon, 06 May 2024 15:47:25 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a110:7baf:6acc:de85])
        by smtp.gmail.com with ESMTPSA id w13-20020a25918d000000b00de6134b2c3esm2255582ybl.24.2024.05.06.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 15:47:25 -0700 (PDT)
Date: Mon, 6 May 2024 15:47:24 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <Zjld/ImGmyBHTLO4@yury-ThinkPad>
References: <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name>
 <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
 <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
 <20240503222338.GA1908482@thelio-3990X>
 <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>
 <20240506175209.GA1425562@thelio-3990X>
 <CANiq72=mSafSJH1hab57LxYfyj_BD7UOtyAerOT8S41MD-MnAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=mSafSJH1hab57LxYfyj_BD7UOtyAerOT8S41MD-MnAw@mail.gmail.com>

On Mon, May 06, 2024 at 08:08:41PM +0200, Miguel Ojeda wrote:
> On Mon, May 6, 2024 at 7:52 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > No, unused can be used with local variables, used cannot.
> 
> Yeah, sorry, I meant `used`, i.e. it is that one the one that
> constraints the combination rather than `unused`.
> 
> >From a quick look at the links in `compiler_attributes.h`, `unused`
> can also be applied to types, while `used` cannot -- it is another
> difference, but your sentence above already implies it anyway. :)
> 
> Thanks for the correction!

I have applied the patch in bitmap-for-next this weekend.

https://github.com/norov/linux/commit/eb21fc0c96b48d1e779a0ab16f9165a3e0cd76ad

Can you guys please take a look at it wrt the last comments? I think
it's OK. But if not, I will resend it.

Thanks,
Yury

