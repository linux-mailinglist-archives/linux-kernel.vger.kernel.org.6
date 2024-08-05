Return-Path: <linux-kernel+bounces-274779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB542947C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A241F217D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C71386B4;
	Mon,  5 Aug 2024 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pKxl4P2T"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01D17C64
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867216; cv=none; b=iWSVXNDw5jHZy+fGuY8bCR8HJXVMGEGsIxOf9PBq4lE9mQN5NaeVV1096P/Xroos+4nu8Wwy2WdC8kCHF/mEi4H/j8rNABklJIBgUbK//aX/fS8koMSHL+0YAHbZPqHQcW1rhrI9BqQPF/rtKu2R1QLxbfv622aWu/zj3RuGUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867216; c=relaxed/simple;
	bh=zcH3B70sJYhkWoWzRDU6zHvLSw7+b2U4xM6ZoHqlSK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrBZRPKTK33+m+4xljG3+9DSnEodavjwtWls9DFvCnYsSLU7plIcCe2fNBjxZB0xBr2POhhlqRHPiRmaE7kmqE227snAO/HDseoUxKysGF387zfLKPZ+4snY0Qyt2yjzzv8nWwWRpaAHrw7Sc0g2hd21NvvyQKPtchP+bmzvWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pKxl4P2T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=wyEUiyrPaJXQSDHIV3L8hLC8OQnIcWhPzCoxxJJef8Q=; b=pKxl4P2TqEJNKhy4Byf5TJVDi+
	WLQ4v+P1p0WKP/wbRNm4w9Gof71kVhDU7equMrwZIQ0NjUqpoF/W0a1D8yZ5WbYphWRruG4HBNuxG
	URVn4Zp01byf952V8e/03fC712myxM/rj0BOmBZHRwWMKXdPtlGUr+mqIXYcFVwzA2S4d2ikNBDki
	RXkiP71Jb4CTFU7sV0b6h50dkObL06tJ7b1RA0axfBUDJP/gal76/CRKUODCdwBBENsFSdpoAaArV
	uzQC4n2LBK+DTeAGb5AYmc4aaeSaVJZoLl9FbkY31KlKyz+LpV9r25G74DBPyw9rvM0/c7k/4IOX/
	OmbLn/dw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1saySo-00000001iGd-3Hsm;
	Mon, 05 Aug 2024 14:13:30 +0000
Date: Mon, 5 Aug 2024 15:13:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Chunjie Zhu <chunjie.zhu@cloud.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CA-392151: fix nfs gup uninitialized iov_offset defect
Message-ID: <20240805141330.GG5334@ZenIV>
References: <20240805075814.10103-1-chunjie.zhu@cloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805075814.10103-1-chunjie.zhu@cloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 05, 2024 at 07:58:14AM +0000, Chunjie Zhu wrote:
>   nfs aio code path, iov_offset is not initialized before used
> 
>   nfs aio function call graph,
>     io_submit
>     aio_read
>     aio_setup_rw
>     import_single_range
>     iov_iter_ubuf           # do not initialize iov_offset

Which compiler it is?  Compound literals initialize *ALL* struct
members.

> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 42bce38a8e87..2121424204c2 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -386,6 +386,7 @@ static inline void iov_iter_ubuf(struct iov_iter *i, unsigned int direction,
>  		.user_backed = true,
>  		.data_source = direction,
>  		.ubuf = buf,
> +		.iov_offset = 0,
>  		.count = count,
>  		.nr_segs = 1
>  	};

NAK.  If you really get an uninitialized value, report it to compiler
authors - it's a bug.  Relevant parts of C99, if you need to quote
it at them:

6.5.2.6[6] The value of the compound literal is that of an unnamed
object initialized by the initializer list. If the compound literal
occurs outside the body of a function, the object has static storage
duration; otherwise, it has automatic storage duration associated with
the enclosing block.

6.5.2.6[7] All the semantic rules and constraints for initializer lists
in 6.7.8 are applicable to compound literals.

6.7.8[21] If there are fewer initializers in a brace-enclosed list than
there are elements or members of an aggregate, or fewer characters in a
string literal used to initialize an array of known size than there are
elements in the array, the remainder of the aggregate shall be initialized
implicitly the same as objects that have static storage duration.

6.7.8[10] If an object that has automatic storage duration is not initialized
explicitly, its value is indeterminate. If an object that has static storage
duration is not initialized explicitly, then:
— if it has pointer type, it is initialized to a null pointer;
— if it has arithmetic type, it is initialized to (positive or unsigned) zero;
— if it is an aggregate, every member is initialized (recursively) according
to these rules;
— if it is a union, the first named member is initialized (recursively) according
to these rules.


Now, it might or might not make sense to spell the initializer for that
member out explicitly on the stylistic grounds, but it is not uninitialized.
Compound literals initialize all (named) members; the only thing left
uninitialized is padding.  If something in your toolchain assumes otherwise,
it needs to be fixed.

