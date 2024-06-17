Return-Path: <linux-kernel+bounces-217737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E634C90B395
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DF01C214EA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43615666E;
	Mon, 17 Jun 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p/8Jvy/c"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30813E04C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634616; cv=none; b=g6VK1dr7tuegwKaGAE+tumQEFwfEqpl7Fi4vhT5w3TlioYn/5gnIewTiXQK8wKaXZw8xLXDex7TJBCOw5HwFfbSK7yTAzh/mnPoavX/Oea0FBH8WT0cQV+61HS+K+8/OXvRtUe7YrZUEIFMCF9EpW7hKEEw/UI14NYvfnqT7kg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634616; c=relaxed/simple;
	bh=z4Ye7WoiFMsS/PnUfef9YutUBmFX1UcoQFbwVSXOYVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bNAah2HI3ksUODso8dDEUiZ96hhYuLKLAHMD6rqyiUsIjehks7gOg5iajeWET2k3pKD5Gommo0EsIFOOOGsEFoNMPContDl5sgdJBmi6xH1Zq+R3BpI6hFjS9rXchspPmiA1nLqM6ZcdXf7Oc02Ui5nBV4NLgt6lVgJrE+EGCxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p/8Jvy/c; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240617143004epoutp01e5343bc7ba8d2df8f95b703f63558c32~Z0RFHrN8H2244222442epoutp01k
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:30:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240617143004epoutp01e5343bc7ba8d2df8f95b703f63558c32~Z0RFHrN8H2244222442epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718634605;
	bh=iyz4lhwHzIQ2xM7JeB8g3lGuDxIxMLt9noIUFj6buu8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=p/8Jvy/clqeRF7LU26bvXj60OGkxl16rOFZwCb38EqTLF0tj55hTzy4kDcraABIJN
	 r259VUvKeaOB8m+n2OUnj2b+F+JxpzjX3T5fS6bkIBmLBQaf5Sce7qxXOrGNcpkVib
	 qyCyafWKR9MGcaMrMKRCqzmACof3F1ir28/Mfuco=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240617143003epcas5p4bb7207b37df8b199a55d7496931926ec~Z0REGWHl61570915709epcas5p4j;
	Mon, 17 Jun 2024 14:30:03 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W2sjQ4RdWz4x9Pq; Mon, 17 Jun
	2024 14:30:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.B9.19174.A6840766; Mon, 17 Jun 2024 23:30:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240617143002epcas5p452f4bfa436d4c58418fe7a073823f355~Z0RCikIXc0444604446epcas5p4U;
	Mon, 17 Jun 2024 14:30:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240617143002epsmtrp19cb132c9b9b0b1f8f339c4c397a620fa~Z0RCcgLrR2965729657epsmtrp13;
	Mon, 17 Jun 2024 14:30:02 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-f8-6670486a2488
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D5.16.08336.A6840766; Mon, 17 Jun 2024 23:30:02 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240617143000epsmtip1d34a910d9e918b9434cddb96b1c5e409~Z0RBaa3fk3010430104epsmtip14;
	Mon, 17 Jun 2024 14:30:00 +0000 (GMT)
Message-ID: <90f3cedb-7553-9007-6ab1-38e1562c8f33@samsung.com>
Date: Mon, 17 Jun 2024 20:00:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] nvme: fix NVME_NS_DEAC may incorrectly identifying the
 disk as EXT_LBA.
Content-Language: en-US
To: Boyang Yu <yuboyang@dapustor.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240617131144.48955-1-yuboyang@dapustor.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhm6WR0Gawa0OOYvVd/vZLFauPspk
	MenQNUaLy7vmsFnMX/aU3WLd6/csFtPamRzYPT63/mD1OH9vI4vH5bOlHptWdbJ5bF5S77H7
	ZgObx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4B
	um6ZOUDXKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkus
	DA0MjEyBChOyM/4dOMJU0MVcsfPgF8YGxkNMXYwcHBICJhLdU3y6GLk4hAT2MEr8nX6HBcL5
	xChx6+x6ZgjnG6PE1kPdQBlOsI7ri45AJfYySpx++ATKecsoMa3zKwvIXF4BO4nvL3lATBYB
	VYkpr3JBenkFBCVOznwCNkdUIFniZ9cBNhBbWCBO4kbDSVYQm1lAXOLWk/lg14kIZEp83ygN
	EXaQuHC1mw0kzCagKXFhcilImFPAWuLZuhtMECXyEtvfzgE7RkJgKofErOX7oE52kbj++TI7
	hC0s8er4FihbSuJlfxuUnSxxaeY5Jgi7ROLxnoNQtr1E66l+ZpC9zEB71+/Sh9jFJ9H7+wk0
	DHklOtqEIKoVJe5NesoKYYtLPJyxBMr2kNjZDDIRFE59jBLnn/9mnsCoMAspUGYheX4Wkndm
	IWxewMiyilEqtaA4Nz012bTAUDcvtRwe28n5uZsYwSlVK2AH4+oNf/UOMTJxMB5ilOBgVhLh
	dZqWlybEm5JYWZValB9fVJqTWnyI0RQYOxOZpUST84FJPa8k3tDE0sDEzMzMxNLYzFBJnPd1
	69wUIYH0xJLU7NTUgtQimD4mDk6pBqa5584KvGzpjFy/WTykfFoKh4NRoJ9myVF96ckKosL+
	z5g7DsxKPHY361ENm+lH67pYgRKlTdf+nGn/cnddtPbs9cIyeeZSv0Wc+Is1d55hebm33IFn
	vc6qI0vZMgRzT0n+nMq+surcSXPfaOfD33/U+2uxmsm++tTiO2lK2UKJJefU9l19OWdTvAM/
	i+qJzGsz3nhd2STklefh1sL/tXleS8Y7sbxtEeWzUzXspFxytnSZZFzo/NDz2GPNStFk36Sf
	ItZHve0iFeelmLE+vXPwuFQoX9mWX+//Ge1bb1pSEn5mB0Od49KH80+X+nSLTDMLr9jY/YCp
	sKFk+9PV4Z0hS7SnzBBsfOIfsKLIT4mlOCPRUIu5qDgRAAH8NPMyBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG6WR0GawZRpzBar7/azWaxcfZTJ
	YtKha4wWl3fNYbOYv+wpu8W61+9ZLKa1Mzmwe3xu/cHqcf7eRhaPy2dLPTat6mTz2Lyk3mP3
	zQY2j8+b5ALYo7hsUlJzMstSi/TtErgy/h04wlTQxVyx8+AXxgbGQ0xdjJwcEgImEtcXHWHu
	YuTiEBLYzSjxbl87M0RCXKL52g92CFtYYuW/5+wQRa8ZJZ79usjWxcjBwStgJ/H9JQ+IySKg
	KjHlVS5IOa+AoMTJmU9YQGxRgWSJl38mgo0RFoiTuNFwkhXEZgYaf+vJfLAbRAQyJZY0HGeE
	iDtIXLjazQaxqo9RYsrb04wg89kENCUuTC4FqeEUsJZ4tu4GE0S9mUTX1i6oXnmJ7W/nME9g
	FJqF5IxZSNbNQtIyC0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwRGkpbmD
	cfuqD3qHGJk4GA8xSnAwK4nwOk3LSxPiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2x
	JDU7NbUgtQgmy8TBKdXAlLXuhY9lh9zLTzuKKr/sD35+fIr9PB9dQ9l5kv0WHVeXr9C/vH7P
	Xc9Qz6TVJQJq27USO4NumG85dHmhyt1dXwoeejOt+XLlwtmJrjLHt6gEdG+1v8ux9t1pY1tW
	1sLrfm9NXjuUT6y75vbOyezz7qZ4hc1hz8Xa9A5yifU3OP6MuFbIYuL314T7sY6XRZX9nMAL
	SenKs3a9eDJTqz9XzdGiU7C9SkbY7tGPl5kywtaLCioXGt88ILTm5cYteqvVojOXXFE/1bKj
	qln0SLeCvO7OSWqX14cv/aD0g72fV+2n/FHppbvfX6mzsbiiEd0bPfEwb8aHPA/u7ztWHeLa
	aPbgUNndyIZvX97+0UroUmIpzkg01GIuKk4EAC9+8MgPAwAA
X-CMS-MailID: 20240617143002epcas5p452f4bfa436d4c58418fe7a073823f355
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4
References: <CGME20240617131354epcas5p189a78f2cedf7f3a3552df5e881e547c4@epcas5p1.samsung.com>
	<20240617131144.48955-1-yuboyang@dapustor.com>

On 6/17/2024 6:41 PM, Boyang Yu wrote:
> The value of NVME_NS_DEAC is 3,
> which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS.
> 
> Signed-off-by: Boyang Yu<yuboyang@dapustor.com>

Maybe this requires fixes tag [*].
Looks good regardless.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

[*] 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes 
command")



