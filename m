Return-Path: <linux-kernel+bounces-187214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981228CCEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D787281F92
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A640F13CFB7;
	Thu, 23 May 2024 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3DNLfj6"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0075101A
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454559; cv=none; b=S80aswxPRVayxRClNeGZBepIgwf+V/ZMyWVuE3O+9WmdXAZwmH/Sjk92AhCWLmKtNIa5vx2aEMMJv67dzQtMvw2OxoTLcSzoaKfgMCzci4S1RHgZbQhSX5eDTlBio/+LLd0bU4zP3Ojb6SV8aDk4MAssKXKyR/fDSHdyRWv3/a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454559; c=relaxed/simple;
	bh=KY0Iw47NNCnBAJlCmUXy1auDIbRJYTjRQ8P0h9sF9sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEFArmM2qcOG9Z5uLqRfWRRjjC3ytElQxuW4SS/JiizrUiGJuX1kr0d8kx9ydkyt13pRNimO/LBcYt6U+rt3EdgFw3poCNdmW2H+EXjWCGdmTY8EcFP3En4+j4+L5eeQx2Q+0b21PNA144KKhdann3HH1ncNl47mjNaPC/GLtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3DNLfj6; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1108926766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716454556; x=1717059356; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0bW5zyBmRLXPGJh5DeyOJNeG1dhNma7UwkHhsIjM94=;
        b=i3DNLfj6cbLyQPE9FcrHuhWRaFQM0XeznWXmY5wcNhBVNwUCm6sxrxaAzYSi8vh7SR
         hb+AkFPpfH6AJiqEEcdwIyqseSK6qN1JO2jsk1X/3JYo69JX8jUsGjip5uU8P9tU4/mY
         iOBLHJrVtRugI0kw/lQcCuo24cU5vFzSZRgMsJtGAXM/1R/R5+3j+gXp0FQMz8dkDes7
         JhWcn8Z1aW/UivdFOJ7HDF4AMbhgEF1ibcRfitsdeyT9jjCjN2dgcBmlxaw2z0T0Crlo
         5SI7DTduIBpAKMoROPSUUwvYbOjMvBhLXwMadHfY3rqk961YsFrsqyB1/BF5dL/QkEwQ
         0ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716454556; x=1717059356;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0bW5zyBmRLXPGJh5DeyOJNeG1dhNma7UwkHhsIjM94=;
        b=R2tHZY1vqBWpf2S7tD6Lgf2WayQnFif8VmvHAx0abpYNIVA9iRDsdk+e+TSDLm4bWj
         nS7/RtR10YRdyYnEiYrlMyYxbE/kEyWECFXdXU5GfKsyBw8VEzGe0ewv2JqKrNEozUOd
         6OkpYomqI6RJalQYlTJlYsy+IFjTqgiSrmwpjJz/OnKEXCK8WcmC3H43PNXsMu56Ez9E
         ycJ1RDh2u428VnSEoCtSA0L58F+Tr0oH5zp6qfqcyuIcQKJK85CC9a8b7LVpEcJI6TpC
         Zb7xRlanJqn/nZcWEWTmcUAoHIQnNUBwB9cj4UOQgncEgOhBvKQACqqbKAzuQa5vNisE
         P1Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWL1ugfwmkeQvKZJPY+J5XA9wahFGzF9u8S/brlV2vqwKh0qzcZzqykFKvOpXyyNyM/WhNxfhn1BshEJCwFcdWzwWc1o7Xwhp8fBRzh
X-Gm-Message-State: AOJu0YzWQ06qmsNSA60mDPISmxGvuJ6HCPDTZkR4cAw+nXSL0Ux+BE+1
	Mh+AKZs2LTs3tRUTSVv3ThxKOrYMJWH4M/zhdrASYUrLxhOPNwcp
X-Google-Smtp-Source: AGHT+IHvZXy1xZJELIdfIqVU0uoHZR5zv4oUPyiUpEwCjdgtxn6yNDrnA+jo0ha5r2+bew3JaX+Omw==
X-Received: by 2002:a17:907:d9e:b0:a5a:89a3:323d with SMTP id a640c23a62f3a-a6228191816mr316447266b.72.1716454555463;
        Thu, 23 May 2024 01:55:55 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce5dsm1898005366b.42.2024.05.23.01.55.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2024 01:55:54 -0700 (PDT)
Date: Thu, 23 May 2024 08:55:54 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
	Mike Rapoport <rppt@kernel.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
	"tkjos@google.com" <tkjos@google.com>
Subject: Re: [RESEND PATCH 00/10] memblock: introduce memsize showing
 reserved memory
Message-ID: <20240523085554.netvftdebmg5ie4a@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240522081647.zlwenenrbrjemlp6@master>
 <ZkxN0yQ7Fb0X26hT@kernel.org>
 <20240521023957.2587005-1-jaewon31.kim@samsung.com>
 <20240521025329epcms1p6ce11064c0f0608a0156d82fda7ef285c@epcms1p6>
 <20240521101753epcms1p50443f6b88adea211dd9bbb417dd57cb1@epcms1p5>
 <CGME20240521024009epcas1p10ed9f9b929203183a29f79508e79bb76@epcms1p8>
 <20240522084738epcms1p80845ffecee4fbab97b34fdf2ce1595a7@epcms1p8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522084738epcms1p80845ffecee4fbab97b34fdf2ce1595a7@epcms1p8>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 22, 2024 at 05:47:38PM +0900, Jaewon Kim wrote:
[...]
>
>Hi
>
>> Maybe you can show the log difference, so that we can see how it helps you.
>
>For your new email, could you elaborate the difference you meant? 
>Do you mean difference between existing debugfs membock interfaces and the one I introdued here?
>

You mentioned the difference between kernel version helps you locate the
problem. That is the difference of your new debugfs.


-- 
Wei Yang
Help you, Help me

