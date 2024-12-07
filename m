Return-Path: <linux-kernel+bounces-435885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0522B9E7E3F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C545316AB58
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA18381B9;
	Sat,  7 Dec 2024 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ofm58Ahx"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467422C6D4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733547504; cv=none; b=JhugAsWdwjR1sQtYp9DVwtU52f/FY6J2Q98vi5AC0lSdtnJcxBvBXzuX9cgHG23MY//Le4P+H8DI5f4ElTZR7juToe030GJqGaFFBTCCjPfHrkacHTGegmEyJVckjoLL+c+Mmao1njvB7zteOl5aT98UrrJjJJuZhYpoj+XPhS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733547504; c=relaxed/simple;
	bh=gh3dWE0k96FzKp5eJhj32bvAqL6eBaXY32TQjJAzF8A=;
	h=Mime-Version:Subject:From:To:CC:In-Reply-To:Message-ID:Date:
	 Content-Type:References; b=pEUjGUkYMpeZISxeHvPu1cG/9jB8VrKUQxgce0C+WH4RZeaVXOPqogSpUKhCHPiwUZba3Ba0EybSSEHoI4DqjLJrNzTnpibu0TuF3JmKgMSb/0BmMjZ8GWGJY7StOQ3efQaAz+/Nb5AUm6LzEG0Kn0bHuID89h9yZ1ocUrpFBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ofm58Ahx; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241207045817epoutp0122c7ea91f8f7cb6b2fd928b1197f9de6~OzEPC7Eaq2020220202epoutp01x
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 04:58:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241207045817epoutp0122c7ea91f8f7cb6b2fd928b1197f9de6~OzEPC7Eaq2020220202epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733547498;
	bh=V8Y1VDl9VeD7JeczT+wKLXz/GxXZYR70pIX0yAVHCl4=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=ofm58AhxluUGJbK1Vc/IP8PRrYP9pycDxzQ32I1QcqsDayYqWxbGphLc/k6LddHXS
	 tZmI1a2eWnxLbX5UWW1MKy+aslesMo1iO/QawEjYWJ5j8o+jcNyZe5hwOIEdk5R9k4
	 TQPv6GYSBeHMKCFBj9sLNLC2B9DSAml0n1BZooU0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241207045817epcas1p19a5dc289c6bc5e720c8916d6b2994084~OzEOj47Wa2762327623epcas1p1b;
	Sat,  7 Dec 2024 04:58:17 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.133]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y4wqr6v2kz4x9Pt; Sat,  7 Dec
	2024 04:58:16 +0000 (GMT)
X-AuditID: b6c32a36-6f5e970000005d3d-e1-6753d5e761f3
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	38.92.23869.7E5D3576; Sat,  7 Dec 2024 13:58:15 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] extcon: Remove deadcode
Reply-To: myungjoo.ham@samsung.com
Sender: MyungJoo Ham <myungjoo.ham@samsung.com>
From: MyungJoo Ham <myungjoo.ham@samsung.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>, Chanwoo Choi
	<cw00.choi@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <Z1Jg2zRT9ecClJH7@gallifrey>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20241207045814epcms1p21e267fe70a87d06cdd4c531248f193e9@epcms1p2>
Date: Sat, 07 Dec 2024 13:58:14 +0900
X-CMS-MailID: 20241207045814epcms1p21e267fe70a87d06cdd4c531248f193e9
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmge7zq8HpBh8OWlpc//Kc1eLyrjls
	Fuuf32ByYPbo27KK0WPl8gnsHp83yQUwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjq
	GlpamCsp5CXmptoqufgE6Lpl5gAtUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQU
	mBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ0zfPJWt4Btnxbv2KYwNjHM5uhg5OSQETCTWflnM
	BGILCexglFj9NriLkYODV0BQ4u8OYZCwsICBxKf//YwQJUoSDTf3MUPE9SU6HmwDi7MJ6Eps
	3XCXBaRVRCBC4s7WTJAws4CjxO29b5kgNvFKzGh/ygJhS0tsX76VEaScU0BT4slsEYiwqMTN
	1W/ZYez3x+YzQtgiEq33zjJD2IISD37uhopLSvTd2Qs0ngvI3sYosePIHDYIZz+jxJSHbVCT
	9CXOzD3JBvGWr8T+1ZogYRYBVYlDxxawQpS4SDz//4UJ4mZ5ie1v5zCDlDMD3bZ+lz5EmE/i
	3dceVphXdsx7AvWWmsSh3UugNslInJ6+EOpOD4mHlz6CnSMkMI9R4tLZZ6wTGOVnIQJ3FpJt
	sxC2LWBkXsUollpQnJueWmxYYASPzuT83E2M4FSmZbaDcdLbD3qHGJk4GA8xSnAwK4nwVoYF
	pgvxpiRWVqUW5ccXleakFh9iNAX6cyKzlGhyPjCZ5pXEG5pYGpiYGRmbWBiaGSqJ8565UpYq
	JJCeWJKanZpakFoE08fEwSnVwNRR1D89TL2ht9Pm6ccbGx4bPj65iuP+wnLezisN53L0NDI9
	BBZIM+aevaHz0FopbO0zsz/hev+eflm3LtdQZhevLYP+lkLtWfMSdYpsdG23L3z2g/tT/CGT
	/a/V65YHzrRySbZXMZQ8+GSafK6w+Bfz5vV3czuTPl0V/h84S3/agyC7lzpaRQXeE77eflo2
	SUZzflhOnv62PaxNZ/+aTN8tpdLxoHO3o1GokMrnvbPsjm/ery22c469f9XaLa0vecUqZDJF
	uGQUrFsvsN3gT7uveWYbZ/DfrQonlhfGs0e1/o76/2Xr+Ve+zMZiK+Z+L34vdP8n591257sd
	kbMavO1KGMpS+bo+NlzlrXCSUGIpzkg01GIuKk4EAKS5DS7uAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206022643epcas1p1db6da634d4da398f553b7dd3cfa3339f
References: <Z1Jg2zRT9ecClJH7@gallifrey>
	<20241103160535.268705-1-linux@treblig.org>
	<CGME20241206022643epcas1p1db6da634d4da398f553b7dd3cfa3339f@epcms1p2>

From: Dr. David Alan Gilbert / linux@treblig.org
>* linux@treblig.org (linux@treblig.org) wrote:
>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>> 
>> extcon_get_edev_name() has been unused since it was added in 2015 by
>> commit 707d7550875a ("extcon: Add extcon_get_edev_name() API to get the
>> extcon device name")
>> 
>> extcon_get_property_capability() has been unused since it was added
>> in 2016 by
>> commit ceaa98f442cf ("extcon: Add the support for the capability of each
>> property")
>> (It seems everyone just uses extcon_get_property)
>> 
>> extcon_set_property_sync() has been unused since it was added in 2016
>> by
>> commit a580982f0836 ("extcon: Add the synchronization extcon APIs to
>> support the notification")
>> Everyone seems to use the none _sync version, and there's one place
>> where they just call sync after it.
>> 
>> Remove them.
>> 
>> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
>
>Gentle ping please; no rush.
>
>Dave

It's not a dead code.

Example: https://github.com/diphons/D8G_Kernel_oxygen/blob/b0717c360f5485badf824fb51cdc8174e2e0a7cb/drivers/usb/dwc3/dwc3-msm.c#L2992

There are drivers (usually .ko) using them, usually Android mobile devices.

Cheers,
MyungJoo


