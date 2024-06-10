Return-Path: <linux-kernel+bounces-208671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9666C9027F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ED51F229A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58B147C74;
	Mon, 10 Jun 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SJV9hHZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C155884
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041544; cv=none; b=ESK0nCQmTtjRyRPGxRxJDz8RyYbMh5rl8rbgDbZa813y+AKPAxpCdfwa2UuuoX6vLHfRoGa7JYgqn9dPz4HSiOcF8auxLbT4cIU4DR+CtqBQB/61nL5+frx0v3ox1ALwiHvLB6nMsZ5TiITXMdAON6RBCqJEPfdZ/wvM7WngyYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041544; c=relaxed/simple;
	bh=dbytZ0vJmzJGe+/iWdHuIAQiKb0TG4Aky72PQarEDvI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ARxrH+dIsPJS5SCDjqskaFNQfj1EK1CJqql7rPOB6gOW5E+Id2xQCF5EbMmgtJInp8LJ5GGFLVJcIVYT1zr1VigAvxoVZQ8FbvET8qSa4x+kO4icH0A9MOBO7YyjABb48U1J22iYSuuapDSc6kYA2FE+JIFSw5vB1vRb6BO4SyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SJV9hHZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E7C2BBFC;
	Mon, 10 Jun 2024 17:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718041543;
	bh=dbytZ0vJmzJGe+/iWdHuIAQiKb0TG4Aky72PQarEDvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJV9hHZlwevrqnKl1cDFRUqOX0JruwMaNnJAA2CiOGTGJGrazuWXP1n985NWxqegJ
	 MRvo+Zacf84eyu7pZb9CtUslpnoRXzatWMZY08JZEmbP47jhqDn4yju8U+SzG9ZF0b
	 JQWVoNu8z4ZS5rucLTIIYFP+bCPgZTLTR6IUPOcU=
Date: Mon, 10 Jun 2024 10:45:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH] gcov: add support for GCC 14
Message-Id: <20240610104542.25a7d777b011d74463df9148@linux-foundation.org>
In-Reply-To: <ZmcCfzJfsKoVvDpA@tissot.1015granger.net>
References: <20240610092743.1609845-1-oberpar@linux.ibm.com>
	<ZmcCfzJfsKoVvDpA@tissot.1015granger.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 09:41:19 -0400 Chuck Lever <chuck.lever@oracle.com> wrote:

> On Mon, Jun 10, 2024 at 11:27:43AM +0200, Peter Oberparleiter wrote:
> > Using gcov on kernels compiled with GCC 14 results in truncated 16-byte
> > long .gcda files with no usable data. To fix this, update GCOV_COUNTERS
> > to match the value defined by GCC 14.
> > 
> > Tested with GCC versions 14.1.0 and 13.2.0.
> > 
> 
> ...
>
> Tested-by: Chuck Lever <chuck.lever@oracle.com>

I assume this problem will affect people who use gcc-14 to compile
older kernels, so I have added cc:stable to this patch.


