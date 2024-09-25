Return-Path: <linux-kernel+bounces-339217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E63EF986199
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71570B3061E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDF3185B69;
	Wed, 25 Sep 2024 14:15:58 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74090D29E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727273758; cv=none; b=gXkH+FE67aWxQDn58N53YPKxJbT3411kUK/tXxYqaaQkmyTyhB202w8+IVb4zW63VVMzFCQfNpluYBO46Jt10dtu/o5Rc6C9tMJlA3z2c1WwH6QrzKElZS6okKsqc7nnmgNDb0fQo6VpN2LSbqjfzyw2mzxFNevDcTnLfL697p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727273758; c=relaxed/simple;
	bh=g3vKOKI5sV8Ln/l9lTdcnm9vxpRMQitsmAn7og+/c7Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYqPx5ACNgKb/yDSlXGUWib8viHqnnqTBPrzMx9Ap0c3KlQCEkTek6bBxu6egOP/bCrQGW6Kcv5BymcUKdcFI7jTBUlSAjXGcvsjn5QNoEFkDM1gOIYmQCOquW25bLpP8dCrL/x+dIBzFaCvVvVD8HhWjLLJL7V4NMO5oavgj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJfL1wN0z6G9Gg;
	Wed, 25 Sep 2024 22:15:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AFBE140B67;
	Wed, 25 Sep 2024 22:15:54 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:15:53 +0200
Date: Wed, 25 Sep 2024 15:15:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 06/15] acpi/ghes: Remove a duplicated out of bounds
 check
Message-ID: <20240925151552.00004e62@Huawei.com>
In-Reply-To: <271a2d24854e1d63c0913e5d68ac565dc0b8dd42.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<271a2d24854e1d63c0913e5d68ac565dc0b8dd42.1727236561.git.mchehab+huawei@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 25 Sep 2024 06:04:11 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> acpi_ghes_record_errors() has an assert() at the beginning
> to ensure that source_id will be lower than
> ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

