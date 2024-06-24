Return-Path: <linux-kernel+bounces-227831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF82915702
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1618E1F25C68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEE19F482;
	Mon, 24 Jun 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q1Y36HA3"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC05107A0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256318; cv=none; b=jQZ9CWqqqemnDdDeMj1AY/5TNK8Cn97od6gQQzVPlMMGw8QCWFBrm0iaxTJ4tATijpi5GAinNutL2IRqyirWR/rgEaCNNL7AMwjLIi/sZVf/3xwAINN6k9FUpeTZCaY/MEnab6KRUAkwkcj0vZvoY+Rn4Ra3ZsW1YUEqmZdl5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256318; c=relaxed/simple;
	bh=rti2Fvstf9MHzW9P7/mRqK8mC4xinnnaLiFZX1S9QC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YVVH3edc3L1Ajuk83s8ipDmOU5Eo/q69ZuURQGTxYQbaqLWNhjmquLmETShfGGR/Yw1pCm5CSSv7LZTVvuQ85Lmf96CeOmzA0sw3xkm42iBaNZqR7km7r8boM2+QVEn576U6gq0nar8fMnYFvP01UbngYVGBX9D2C5lhXaLeYAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q1Y36HA3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIULO3016060;
	Mon, 24 Jun 2024 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=n
	ehmikWmdM/kJtb5KX//x+xdyw1dPk//cLoVAZPSe2w=; b=q1Y36HA3RW5h/eW7Y
	ZCxpAB3jeZCroqn1RZZ2rKq/rZSxJXc7ipfmCy4dDAGgB8jxpT4MMC1zW8pNxDEN
	uSTGF3NNnhnvzo4djRAdBxGB1hlwH8Y6JdScgGHjqffV9HekGvama6nONDIWn0ki
	E7x6CCiSrXsUzEsD5WpxH+IDgCinJNNTCpMFs8neqQUNlVRAHuw2+upYEmxrHPD6
	IsF8iDyfst+6ZZ8kh1ZutIFNj/8S5MqNHPsyZxdAVab00gYeIABcwdhydR4OsVvr
	6EW1/Ki84r8KwqdJg2kfSggTp8OVQDZiwSS8A3TIHVDApiIbIUEwicpv4fRzuuFZ
	H20JA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yye4402qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:11:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45OJBeBI011860;
	Mon, 24 Jun 2024 19:11:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yye4402qb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:11:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OIUMNQ018115;
	Mon, 24 Jun 2024 19:11:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yx8xu2ncn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:11:40 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OJBZNj26936000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 19:11:38 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAA6658055;
	Mon, 24 Jun 2024 19:11:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D4858059;
	Mon, 24 Jun 2024 19:11:32 +0000 (GMT)
Received: from [9.124.215.163] (unknown [9.124.215.163])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 19:11:32 +0000 (GMT)
Message-ID: <11f9cc04-91eb-4a70-9ff0-5c6f24483cd3@linux.ibm.com>
Date: Tue, 25 Jun 2024 00:41:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michal Suchanek
 <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour
 <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <875xudoz4d.fsf@mail.lhotse> <87ikxza01w.ffs@tglx>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <87ikxza01w.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5Wn1QeCSWkHb9lQ2k2z3gmkExtQTKTLo
X-Proofpoint-ORIG-GUID: fwa8IBLDVE_kaukpVhZqEagT37MAZ4-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=800 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240150



On 6/24/24 1:44 AM, Thomas Gleixner wrote:
> Michael!
> 
> On Thu, Jun 13 2024 at 21:34, Michael Ellerman wrote:
>> IIUIC the regression was in the ppc64_cpu userspace tool, which switched
>> to using the new kernel interface without taking into account the way it
>> behaves.
>>
>> Or are you saying the kernel behaviour changed on x86 after the powerpc
>> HOTPLUG_SMT was added?
> 
> No. The mechanism was always this way. Only offline nodes have been
> skipped. x86 never checked for the core being online.
> 
>> It's only x86 and powerpc right?
>>
>> Having different behaviour on the only two arches that support the
>> interface does not seem like a good result.
>>
>>> What is the expected behaviour on x86 when enabling SMT and certain cores
>>> are offline? 
>>
>> AFAIK no one really touches SMT on x86 other than to turn it off for
>> security reasons.
> 
> Right. So changing it not to online a thread when the full core is
> offline should not really break stuff.
> 
> OTH, the mechanism to figure that out on x86 is definitely different and
> more complicated than on power because the sibling threads are not
> having consecutive CPU numbers.

wouldn't topology_sibling_cpumask have this info? 
If the mask is empty does it mean the core is offline? 

> 
> So I'm not sure whether it's worth to make this consistent and I
> definitely can live with the proposed patches.
> 
> Thanks,
> 
>         tglx

