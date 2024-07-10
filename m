Return-Path: <linux-kernel+bounces-247973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E34C92D6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285682837EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D93A194C61;
	Wed, 10 Jul 2024 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQV5Izhp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7B4189F54
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629902; cv=none; b=rkW0FoeuGL30HSamFiEeKWoEZL7FqOxKcEGYg/PKljKSqmR+JN+CqnXApnYBTFRD/nFYGF/VXkOHCuHdeDOKUbi8Yd+ornSAOKhtwpTsHj81rSCNI1r+20PXTbMy7HbHj4DU3IwZHcJ4sc3l16wTNmIdIcZyVlmNY0X/hiPq5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629902; c=relaxed/simple;
	bh=VA2aOcija9xK69zbqUNtWW2W92ov15nFIxfiUABikJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbyW7WLznTcrGo9/hPRGoP3+5Cdvpp10VDPJ2uE8O2ZvPKj1eGsf9I5P0CCzldqiJpbKicBb+ZZ1xYrr7kdmUipQOSjthu5fhvN+g9z2vfitEH+6t7pv77diNG/1//86qi5XozsAzWOhS53rNaG5SCXV7N/c4AKr0a1khKxhnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQV5Izhp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso4631846a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720629900; x=1721234700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvEFbSSl5EC9M/45TkKe8bD8VlEaxGQVRuoyizsd7IU=;
        b=eQV5Izhph4WwJzcwlHH+Z3TmDAr+BVdrmW4wcecRIaGhZtFWxBs14JxCuC2X9L/Q98
         ga1YD+1WA/v+epKSWNxLBw1tSBXonu4E3IURbVW5zsFryjuYMYcbYcIHTwbOQk70O1BP
         G6p5CrxOoTFK168OxXXAWqguEZ+nRUe3A3nTh/O9W27AXBCCAggUT/LA67NP3HSgWtHq
         GuRQfDO4NXpcibAYe1MKVz01bykmLpOqyi0xTWPBPktkfEnIEvwNhh1MlJHN830LiKiu
         IkjJ6YOJ/hyGfKHOcqfVnpoSt03inxBpYbHeJ7UchzSPQ5jdV2fZTomfHwq1wFYl0NNo
         oB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720629900; x=1721234700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvEFbSSl5EC9M/45TkKe8bD8VlEaxGQVRuoyizsd7IU=;
        b=TTrVwFg/VKoymZKs+aSzGAESwHlMudav6KL8flaakdum/u9C2E5BHFfH0MWIy6wIFt
         T4+3coV+D0c2AHNBbog+zYwrQthzshXssDIQKxsBJoCWsZuzLGx9Nr8oHo/iYIIABZ0O
         QUVYuuqH/GLni98dKraHr+PIDYbup6ygy2a1Uw8N07yCJ8psP/HseJUNSkmpzXzxkqVD
         ZwnlAP/Rr2TBuNPxnWFKpVxeOelbbFIQj+5LjYEeQfMqmlMJ93yuBLdIvvfSjzb7QEYX
         v5Xv5qWz6cvN8LswQqnLyYDFuQrhhcXyvHE/4/ktuQhralyiUp1YK1G4TSKchqj2fHlD
         wf4g==
X-Forwarded-Encrypted: i=1; AJvYcCWStpkO8DkzTy8l/vqjgMtuvOCWNNTnc97IcCkM+NTJjLLywqd3Q+XvymBMzn1kFXv1apN6KE3n4Yd+hPKzvLeKCgJvYTCQF/YLVTEn
X-Gm-Message-State: AOJu0Yw3uBlUIhuxfzWURNAGOIolmwEHRbibO1Z/Kh9G1dGVNeU2mfMb
	LH5VFFYrfSXAjgz62sztCp2I3tUoV0h51yewlwqAcpzt0cymOrmV
X-Google-Smtp-Source: AGHT+IFEQRDn4kSZEB7HQWHkqHrFC7+HpCBFwryBW5v4K7aJ4TTE+USYTZW/es0nD6jGSmW9sIItxA==
X-Received: by 2002:a17:90a:ca87:b0:2c9:7ae1:8f62 with SMTP id 98e67ed59e1d1-2ca35d599e0mr4578910a91.46.1720629900251;
        Wed, 10 Jul 2024 09:45:00 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a92a60esm12318604a91.8.2024.07.10.09.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:44:59 -0700 (PDT)
Date: Wed, 10 Jul 2024 09:44:57 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux@rasmusvillemoes.dk, willy@infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radix tree test suite: put definition of bitmap_clear()
 into lib/bitmap.c
Message-ID: <Zo66iTOi8548Taxo@yury-ThinkPad>
References: <20240710095554.16725-1-richard.weiyang@gmail.com>
 <Zo6z_AuI6U8JBvfk@yury-ThinkPad>
 <20240710163134.a36xircnefbz5m6n@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710163134.a36xircnefbz5m6n@master>

On Wed, Jul 10, 2024 at 04:31:34PM +0000, Wei Yang wrote:
> On Wed, Jul 10, 2024 at 09:17:00AM -0700, Yury Norov wrote:
> >On Wed, Jul 10, 2024 at 09:55:54AM +0000, Wei Yang wrote:
> >> Instead of keeping a bitmap.c in radix-tree own directory, we can use
> >> the common implementation in lib/ directory.
> >> 
> >> Just move the definition and link some related libs, no functional
> >> change.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> CC: Matthew Wilcox <willy@infradead.org>
> >
> >Hi Wei,
> >
> >bitmap_clear() is not used in radix tests, and in fact not used
> >anywhere in tools at all. Unless you have plans on it, it's
> >better to drop bitmap_clear() from tools, instead of bloating
> >the library.
> 
> I guess you didn't try to compile the test. After remove the bitmap_clear(),
> we see this error.

No, I didn't.
 
> cc -fsanitize=address -fsanitize=undefined  main.o xarray.o radix-tree.o idr.o linux.o test.o maple.o slab.o find_bit.o bitmap.o hweight.o vsprintf.o regression1.o regression2.o regression3.o regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o iteration_check_2.o benchmark.o  -lpthread -lurcu -o main
> /usr/bin/ld: xarray.o: in function `xas_squash_marks':
> /home/richard/git/linux/tools/testing/radix-tree/../../../lib/xarray.c:139: undefined reference to `bitmap_clear'

Ok then. If xarray userspace test pulls code directly from kernel
part, we still need bitmap_clear.

Since the function was introduced, we wrote an inline version of
it. We usually try to keep tools implementation synced with the
mother kernel, particularly for extra testing coverage.

Can you please send a v2 that syncs tools implementation with the
kernel one, and can you also mention how it is used in the code,
so those lazy folks like me will not get fooled with grep.

Thanks,
Yury

