Return-Path: <linux-kernel+bounces-339191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3470098613A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65B041C26B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4417C1AD9EA;
	Wed, 25 Sep 2024 14:02:43 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E81917C9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727272962; cv=none; b=gmqfDyl/8E2RzDpNKbmQcwjD3rOzFjQoKu1dJmvE8wW7fhggYV6vdM+OMvsPPyd30zZaQTsqY70AVOin39E7fIn9/iaVFLySk6/0mhhRzDZSXgdy5NGzVlBdTdDLPXGJxK+vx46u03v+QdCdDoYcikP86CTvl66N50xcU0ISWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727272962; c=relaxed/simple;
	bh=RRm1OskvFYeMvpnFDFDTrikPsbnJxGdeqRbaCr7IXWM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DojMw7Ez4425Szr9g+YYMXXR2dx1MI/3o4IpLiNZD6jnjGbwB7Km7ReJe/Cs/qUXCm5CmyPxTYBPHuQrQY4UVc/Y19d4n4/ZtD6NfKYe9TqPV78MZAF0NMzFo2piCJcYYOizX4F245ZI+84X61dVWjyKJ3nrymUtjsbM0lhDthY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XDJH16KMVz6D8wR;
	Wed, 25 Sep 2024 21:58:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CFAAE140498;
	Wed, 25 Sep 2024 22:02:35 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 25 Sep
 2024 16:02:35 +0200
Date: Wed, 25 Sep 2024 15:02:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
	<qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 01/15] acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
Message-ID: <20240925150232.00005374@Huawei.com>
In-Reply-To: <0518c86d8724ba7f9986727676b64c531bd26b6f.1727236561.git.mchehab+huawei@kernel.org>
References: <cover.1727236561.git.mchehab+huawei@kernel.org>
	<0518c86d8724ba7f9986727676b64c531bd26b6f.1727236561.git.mchehab+huawei@kernel.org>
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

On Wed, 25 Sep 2024 06:04:06 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This is just duplicating ACPI_GHES_ERROR_SOURCE_COUNT, which
> has a better name. So, drop the duplication.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
FWIW
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

