Return-Path: <linux-kernel+bounces-398385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0D9BF0A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF7A1C216F1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A737200CAC;
	Wed,  6 Nov 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rN69y11u"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6821185B54
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904462; cv=none; b=GeUZWjd17WhhVLRVm8QAdabMugpVzYdzywK0tT2gT3TGpq9B+OvzpUasVgrORDc9/Ook4lvCyji5d4ptyScIy9AOIRWjCOXgTT8xoxBAa76PXKdEJu0Tc5drofrhDD84te05xjlwCycsjNjV2axJQbOZuICjSOy6AmNTXurR9iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904462; c=relaxed/simple;
	bh=UBkyYkM7yZxEn2HqX/3tK13+c+tzXmcOW5Odo3FsrVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ay/IwCT17NIGdY55C5EWBOHXGzthxy0E9Zx1VICmKSaPcsSrGdGiHWEBh7feeXyG+UnLKqySW1B6udvXdCkzPQhpLQ43Gr1n5wbPYDTJmhiIYjimdfYrMXFZPgpzbGNvGPzVmPi0/hx2xjy+rCK98aWN7aeZG+AxzZrpqRZSN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rN69y11u; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbe26e25-4dff-4933-b9ba-ee3a2ea4780d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730904457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CSqAn83aGHmQw08OvtKkU7HWvHT2pI7caUmyZGh/UJs=;
	b=rN69y11uBEnx9rK5OlRNHkem2tr5iDkLRikqdkoXmwjU98/tUwWTDc7wVKIo48FA5h8XG8
	geF3vjTZzB7aSBIQ+Cl3DpdxBqV0Rb7p1SA+0er7nVeJ79+9FTlWiXzPOLPUifywnBR6r9
	YvX+tC6JmjR1anDc9lpQyINtzmKH+ho=
Date: Wed, 6 Nov 2024 22:47:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/5] sysctl: encode the min/max values directly in the
 table entry
To: Joel Granados <joel.granados@kernel.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>,
 Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>, linux-kernel@vger.kernel.org
References: <cover.1726910671.git.wen.yang@linux.dev>
 <mmmu2glg4cmopjfixz6e54fxnj5ylro7szyo3czn6dwqie2vdj@by2mk2ftgprp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <mmmu2glg4cmopjfixz6e54fxnj5ylro7szyo3czn6dwqie2vdj@by2mk2ftgprp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2024/10/28 22:46, Joel Granados wrote:
> On Sat, Sep 21, 2024 at 05:28:59PM +0800, Wen Yang wrote:
> Just FYI. I'm waiting on an answer from
> https://lore.kernel.org/all/5yfnu64fqsuahcmifvqdaynvdesqvaehhikhjff46ndoaacxyd@jvjrd3ivdpyz/
> as that one has to go in first. Right?
> 

Yes, as you pointed out, this series depends on it.
We have sent v4 according to your suggestion:
https://lore.kernel.org/all/20241106143651.6435-1-wen.yang@linux.dev/

And once it is OK, we will continue to make further modifications to 
this series.

--
Best wishes,
Wen

