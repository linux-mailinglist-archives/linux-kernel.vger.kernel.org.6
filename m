Return-Path: <linux-kernel+bounces-347997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEDE98E149
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EFF1C236B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410451D14E9;
	Wed,  2 Oct 2024 16:58:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800F21D14E5
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888319; cv=none; b=nbQQdYHlbjUTpam+ITlQYC9ZgLDciBnanIWVL2nn54Obh6W7Diq74LSZikNqKAL2ov9IYywugBMvF4YGpX7Py5eU4TnNUAjyMXs46MBqNx1vpNudjl1lU9Akkhi7BKtvlB/CqwKBTju9i0uJ3gRy7QSy8tX9pB2n8r9HZjUtjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888319; c=relaxed/simple;
	bh=hEcK14ChMIGoBXyLxSWaBn4rRpaD1fKG7n9Ou36BNts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvDyYFWJfTvX3NPVD5EkFehNg6mgGi8VECBvbvJWNrLP7PYDmlfig7XKYedHLdO5pF1vluA4ZPCbn5cmRC8sKCaRPv6sIcVWt0Y3AVwpJoQPtR5/4zKy47ceUXE042O8YyH2rZcy3z4/60UQhiVepy4G1QFAAxhly4LRFU3F1PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59044497;
	Wed,  2 Oct 2024 09:59:07 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4013F64C;
	Wed,  2 Oct 2024 09:58:31 -0700 (PDT)
Message-ID: <8215ccbf-56af-448f-bcec-a0e8c3f845c1@arm.com>
Date: Wed, 2 Oct 2024 17:58:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Content-Language: en-GB
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "'x86@kernel.org'" <x86@kernel.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: 'Fenghua Yu' <fenghua.yu@intel.com>,
 'Reinette Chatre' <reinette.chatre@intel.com>,
 'Thomas Gleixner' <tglx@linutronix.de>, 'Ingo Molnar' <mingo@redhat.com>,
 'Borislav Petkov' <bp@alien8.de>, 'H Peter Anvin' <hpa@zytor.com>,
 'Babu Moger' <Babu.Moger@amd.com>,
 "'shameerali.kolothum.thodi@huawei.com'"
 <shameerali.kolothum.thodi@huawei.com>,
 'D Scott Phillips OS' <scott@os.amperecomputing.com>,
 "'carl@os.amperecomputing.com'" <carl@os.amperecomputing.com>,
 "'lcherian@marvell.com'" <lcherian@marvell.com>,
 "'bobo.shaobowang@huawei.com'" <bobo.shaobowang@huawei.com>,
 "'baolin.wang@linux.alibaba.com'" <baolin.wang@linux.alibaba.com>,
 'Jamie Iles' <quic_jiles@quicinc.com>, 'Xin Hao' <xhao@linux.alibaba.com>,
 "'peternewman@google.com'" <peternewman@google.com>,
 "'dfustini@baylibre.com'" <dfustini@baylibre.com>,
 "'amitsinght@marvell.com'" <amitsinght@marvell.com>,
 'David Hildenbrand' <david@redhat.com>, 'Rex Nie' <rex.nie@jaguarmicro.com>,
 'Dave Martin' <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <TYAPR01MB6330C74036E795940F032F5D8BBF2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <OSZPR01MB879814A1694F789D4DA4BABF8B802@OSZPR01MB8798.jpnprd01.prod.outlook.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB879814A1694F789D4DA4BABF8B802@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello!

On 15/08/2024 08:04, Shaopeng Tan (Fujitsu) wrote:
> I have no other problems with this series.
> reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Great - thanks!

James


