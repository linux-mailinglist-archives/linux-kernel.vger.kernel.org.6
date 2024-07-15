Return-Path: <linux-kernel+bounces-252664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D370993168E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5A428760C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178C18EA85;
	Mon, 15 Jul 2024 14:20:17 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B791DA26
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053216; cv=none; b=G3nl+OW+2va+Zb8SoOcA7ldRoO2ITidcF0M+9t4xueqIFRvkUCQ4Vs9LuLpE5BEPL7cldPPe0cbuBUfnlqNksh2ndRwRxM7weRU3RotrsCWLNmS8LYz5wKIYxDD6dY6Y1BktOT4IyFLx4fdRjGfFMSgSF0wQSo54H+XheBBMOCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053216; c=relaxed/simple;
	bh=AWMw0cafNhtHC8XtAnvVWUKBQupr8Pd4JKlwFgbfvZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbOB0nMKZqV3+ld6hvsW4w6wTjWwYYgduQRKyTUTwFpYAi5nZGXbbgALlgdWofmkhwjcKL/rPqDkqqlQ5dRDsLn4/JdEzWgmaqzEWgQoYg3h6E7fIdvmiuvs7zFwaxr3EHi9mvVWYvjHXp/aLM8k4MBIYQ5lsgF4J8yBYY1/9sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso548550066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 07:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053213; x=1721658013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe2ocwR887/MyfdxwsSqmGKhSeTWanzTCLP5XODMd28=;
        b=IKhckxE4A+LrzWz5IosIOnZqta8K1b/kJXQLVI1RYob/20x3aKhsUypHiZvC/yrGY8
         TYhAgyRlkkOOIJxEbNoXSO1m9YFT0AYmYtDHuoku+hZqFInU2xkXK3YgxQUOJwKexkSG
         FmWyVj8fknFH2gX4Wm5H/8wWmbzoCtvRukyVlZcdvx/L8PhILwPwHBJ0JP+It18P85JK
         Fkvs8pf18VaIlUZ1ItKgwQpxk35nBiLixpCkVV5rGnt2n5HZsdf7I7mUU+yC1fiFNfDi
         tOKCTvSdTMwYN9dA/67Rp9/9i80auJRGSUfvm+TXr3NFhytcxy9dp3IJrngXv903j3PQ
         kfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu/ZgjqSRPueVnyEj862zTNAq2QAzXGxm7ctTy5n7niL7XXJQCD5N2E30WaY3x1EWffQkQTQaJHdVuBbhzGzdxvIklzHJrbbJiknh/
X-Gm-Message-State: AOJu0YyxSKPRoOR/D936HfA0F83E6OvawMaOam+eDoE8/q/UMhiEB6UE
	J/5qYHR6q+1yxceYU3noNBTbKFx/79fVhkulyw2BMKeo5tc9Xpxc
X-Google-Smtp-Source: AGHT+IHnAAjwmBEMDYiRmG/ciRGLV9hRCUDE7SM2UXFvT0Y3b9+ekqfwE9qkRITkmYi2uSBEhmjaVA==
X-Received: by 2002:a17:906:2819:b0:a77:a415:f815 with SMTP id a640c23a62f3a-a780b6b1f41mr1135103366b.20.1721053213297;
        Mon, 15 Jul 2024 07:20:13 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7e50sm212174066b.69.2024.07.15.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 07:20:12 -0700 (PDT)
Date: Mon, 15 Jul 2024 07:20:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] x86/bugs: Add a separate config for GDS
Message-ID: <ZpUwGr+TwsY++k8W@gmail.com>
References: <20240422165830.2142904-1-leitao@debian.org>
 <20240422165830.2142904-2-leitao@debian.org>
 <20240712172132.GFZpFmHBJHte2xS1fr@fat_crate.local>
 <ZpUSvl5eKgkLeJrg@gmail.com>
 <20240715121703.GAZpUTP-8TJpZBCWne@fat_crate.local>
 <ZpUlmf/iVgo78h4J@gmail.com>
 <20240715134337.GBZpUnibQhORw-MpSR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715134337.GBZpUnibQhORw-MpSR@fat_crate.local>

On Mon, Jul 15, 2024 at 03:43:37PM +0200, Borislav Petkov wrote:
> On Mon, Jul 15, 2024 at 06:35:21AM -0700, Breno Leitao wrote:
> > Regarding this patchset itself, what is the patch forward?
> 
> The path forward is for you to wait until I've gone through them all. We have
> merge window now so not in the next two weeks.

That is fair, I didn't mean to rush at all.  Thanks for looking at these
patches!

--breno

