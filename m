Return-Path: <linux-kernel+bounces-251235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56232930281
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6201B22824
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F98132125;
	Fri, 12 Jul 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxYrB93E"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7D38DD9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720828492; cv=none; b=MdvlFRJQiqFVr7Gt+Pu8P2S9WsH0POAjAUMXjdBB+JKpANfDDiZWOY0jFuZ8RghcLamxojGQez7TWu1b9NO0arxgXrsqQN485rJ5WCHt35ZHGx+z/5VepZPojWy2IHuYAjqjkM3Um8twlmkXhISs+eYgNmL9IrRJP4gS5LIGjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720828492; c=relaxed/simple;
	bh=YE6K7R8gAe+h184TeCU2xVbL49r3TsltcJZ+ZLh755g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EclCqJDEQHpJPtbIU5W+aa4l8InFhqpe3vYh0rlpBq4h45TuKu8BCyvFhDpV0ldx2gMPM24YJ0I+IGIyVCh9YHCiohCDv/Tbt1m46rQY5VDQzrIdw/Gxn/60mqSRTKhzGnGIwd5Mqcyh6qkRsJAnjTE9Rc9iI1OrDZGBd4vDNUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxYrB93E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b1207bc22so2233695b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720828491; x=1721433291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZifc3Pwdz8+QdK0J0oDpsikoywlYN13Xs5CJ3nc9A8=;
        b=GxYrB93Efe3pRh+x95H1VX8RnF3g3HpsDxSjQLUasAD3Gf7wO0j0DBQ3629fOzwesc
         Hkw/jsjYKEZgUi9re4KxP8jQofeI2qf2EBpFQfI4IyRf56GL632R8nTUIv+zzXHjsdJ6
         BK8u99FkJGV4EoaTD/wV7pebIQHo1G5q7jTjG3lk/jiUUjDX0ZqfVoevI0wvud/wom2v
         T6bFEQHu/vYO5+APyknhns0tF7LKjtSxQM5cA12SKvl7/24y1Ij3uWcJAoaucFWytOP2
         F/b9rNL0GKE61NZSLylck7dEWULwlaQMK2stuPDMo3+Nte8ALCR0YCL4IK2mmPZQ/Muq
         Nzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720828491; x=1721433291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZifc3Pwdz8+QdK0J0oDpsikoywlYN13Xs5CJ3nc9A8=;
        b=Sn8T16vHQ8C81qs+PLHXgrNAdEWFa/RQajcBPMPmMAfJyjJLVHHjuhKXKWJtYTj/PB
         f+STGVmyT929bLaVCc26mu+J0dFH+GZcUs9iUFWxNQjiD+r1GcZKVtOL+5KfIWEygtrE
         AOrVzraF91kloMElxawvHZIX7Td+AjkNBAOzS/+hHZr4xRIf6OX9kz2Szv8TCmwhtOAh
         czDLakeKSocLxoRDRcOhnjIl2WyP0rpwnsL6+kJ7ycMHH+Pqb5EIm+XfShVNrb8THNR8
         rDfJpJO0kwvzvzq6lsnWd7m/5Jx6gXqYe/fLLUh/HvKVqm2wRoRJrptVOJ6Y/HNQu/Yh
         fm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSb+rfBVRq2FldDSHDtrF+HqQ8kY11xw7/5mEPJGzIqmat/uabmQRdqpNQIlnRzZ0Ln/yDVP/RlbkLYFWN0IwZGIovTYvsYxmKZvBp
X-Gm-Message-State: AOJu0Yz2oxBsVl8HE0s5o95gZoZPAgOLIhf9cqT8Yq70z2EUw2kgepfC
	XapaUc+QtBUwTIA+3iTZzZYg5UpXWqF+hI0AAyZCY0qKWs9Qic2g
X-Google-Smtp-Source: AGHT+IGVAIDpkYPZ4wIDiOXzfW/rMMhvWd1QvMpcZH0QCKaTTIvEEf0n63/+Y48Ii3uPyJSca0Rj4g==
X-Received: by 2002:a05:6a21:1807:b0:1c3:b234:ccfa with SMTP id adf61e73a8af0-1c3b234d008mr8697976637.52.1720828490647;
        Fri, 12 Jul 2024 16:54:50 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c916sm105319b3a.42.2024.07.12.16.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 16:54:50 -0700 (PDT)
Date: Fri, 12 Jul 2024 16:54:48 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] bitmap: Switch from inline to __always_inline
Message-ID: <ZpHCSKuKDjzuSmXx@yury-ThinkPad>
References: <20240711163732.1837271-1-briannorris@chromium.org>
 <ZpFhv5VSYZ6jnsd4@yury-ThinkPad>
 <202407121059.9FC2D0DF@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407121059.9FC2D0DF@keescook>

On Fri, Jul 12, 2024 at 11:01:13AM -0700, Kees Cook wrote:
> On Fri, Jul 12, 2024 at 10:02:55AM -0700, Yury Norov wrote:
> > Hi Brian,
> > 
> > Thanks for taking over this!
> > 
> > + Kees Cook for GCC
> > [...]
> > But I'm not sure about that and don't know how to check what happens
> > under the compilers' hood. Can compiler gurus please clarify?
> 
> I don't know much about GCC internals. I just ask GCC devs nicely to
> help us where they can. :)

My concern here is that this __always_inline may hide a compiler's
inability to inline things like that properly. In that case, we
shouldn't convert bitmaps, and should file a bug to compilers.

From your and LLVM people comments, it seems it's OK to convert
kernel code. I just want to make it explicit before moving forward.
 
> > >   Subject: [PATCH 1/3] bitmap: switch from inline to __always_inline
> 
> We always expected them to be inline, and if we need to hit the
> compilers harder with __always_inline, that seems sensible to me.
> 
> Reviewed-by: Kees Cook <kees@kernel.org>

Is that for bitmaps only, or for all files in the patch?

