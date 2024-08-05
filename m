Return-Path: <linux-kernel+bounces-275033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF74947FD3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D40AF2820BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E48315ECED;
	Mon,  5 Aug 2024 17:00:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DC15E5C2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877259; cv=none; b=nmtxg8Kxmk9iYy/PP4uAqKG/yScqrKiLMAl+THWQzt+7MB8uwVQZRjHtuepKIA+Q1SdGXkWv9+TtwRr+4v/OHiQrATNXcvTRWT2qkPXip2fb5zRU9oU8DgAXeBJpHyjVKOgL7JLni68CYSzFY80pYEO0EI3iAZPR62UG+y+zwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877259; c=relaxed/simple;
	bh=C0Lb2+ikMjyrzJEP0TPmYTOl2+OWkSA21UCi+5HjmCQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRbss6rHeLCwASvMoWKHvcHCSypEN3RLQku6jkbn5WglC6ksUVbQaLAX48U0l98UEPVv3LxuE8hME7/gi3xemJjo9j7SmA9sdpMrG3bc1mOy2M0hagqRdE6z1yuf9L25jlBO9opWSUyyMx899g/OVO8kICd5Twl8fE7NYPFz49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wd2gm2qvjz6K7Ft;
	Tue,  6 Aug 2024 00:58:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 75BD01400F4;
	Tue,  6 Aug 2024 01:00:54 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 5 Aug
 2024 18:00:53 +0100
Date: Mon, 5 Aug 2024 18:00:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric
 Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 5/7] qapi/ghes-cper: add an interface to do generic
 CPER error injection
Message-ID: <20240805180053.00007c5c@Huawei.com>
In-Reply-To: <51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
	<51cbdc8a53e58c69ee17b15c398feeeeeeb64f34.1722634602.git.mchehab+huawei@kernel.org>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri,  2 Aug 2024 23:44:00 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Creates a QMP command to be used for generic ACPI APEI hardware error
> injection (HEST) via GHESv2.
> 
> The actual GHES code will be added at the followup patch.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Looks good to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

