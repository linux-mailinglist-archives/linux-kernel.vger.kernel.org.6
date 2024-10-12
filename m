Return-Path: <linux-kernel+bounces-362556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A299B650
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F3E2824A8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1D81751;
	Sat, 12 Oct 2024 17:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RA82LZYk"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC622083
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754259; cv=none; b=VidAMQqKHw195w2yaehfZHxGWShmz3oBMzn6OgFbTGkTzYslSX7wEToFBYUfm5tHznSkL7oRyT9Se5fr2V7b7Q7jwHkp4TLGYEPKWR0PRwUw/aUR5zA5Y0i2JY4RcvreiFF/g4e/iKS+T7QDvHREG6XE+V0baW/F4rRHcniAW/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754259; c=relaxed/simple;
	bh=jVDqBAhUY3M8czcxBDbT94NzTnNrDz4Vme4oS6eXyh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuRxd3twRP0rsF+dWCXvWu4Tx4jnmOd4T7LWMUeC/ULsmFmc3H4HQ8o5NvdDp6b3uD+ZE2cKqP5MNboxilkVi3FKZRBZ5jBNJIRJVAaSFkC4Gt3hMzV/UEU2JPXKP7djIIbFfhQoef47RdSk4sajYHEltoUPp1s+E2J/sx+Fbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RA82LZYk; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Oct 2024 13:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728754255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KO/NEYefuue7m+901ruV3ErJj5nKzqK4+hiAYMFt4bw=;
	b=RA82LZYku5WaFmRCPp1slvqNlrhBDiIW0wBRSdPX+vg7FjrCdvVqz7texdM3vJ3zoSA+3/
	x/1CpUKg5hnFrPn28r/7XnrQlanFiVUAZwyatFGUZYo3Gjft5ok75WhVQRkC68uu9xwx/Q
	ea2scYX4vHPEHOm42Vzt036azP2Bm6o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Youling Tang <youling.tang@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH] bcachefs: Simplify code in bch2_dev_alloc()
Message-ID: <4iwneao62n6xuniitihvhp7ojvt2pkjtisnrnax7hyzztyktxm@yn4unwrqqjpb>
References: <20241012075902.1320946-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012075902.1320946-1-youling.tang@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Oct 12, 2024 at 03:59:02PM GMT, Youling Tang wrote:
> From: Youling Tang <tangyouling@kylinos.cn>
> 
> - Remove unnecessary variable 'ret'.
> - Remove unnecessary bch2_dev_free() operations.
> 
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>

the 'goto err' style is more readable when you're staring at tons of
code

