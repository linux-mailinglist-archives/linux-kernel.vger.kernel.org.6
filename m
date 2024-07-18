Return-Path: <linux-kernel+bounces-256216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E758934ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFDE1F24545
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED281737;
	Thu, 18 Jul 2024 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BN2L5sOU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460A28DD1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721294798; cv=none; b=GT1vqD4tG+CoO3Iumc82ooBddC5xnewNJ1atwDSd2klknkNUmM4ZjO4yPlV18ThEmo/PixMEMkbVaMhUjWO3GxghELG2uXI2I3jFjvRuVjpoPXDRA4KY0no5sNMVMPiT2OyXYEY4s6Nxq0GIF0C/NNAVQcr5SF/Dl8xy2m4svN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721294798; c=relaxed/simple;
	bh=oNm1Sb952AQl6uIuqRzYY+o4N9rSksdo1G8MX5yLFwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=XLRZ5nPDPFmlcgupxbpnvjcgV7AGxdge/ciDYMiRDcuPuhMb1LAOi9HI0pu4Mu2YuU7J3sEszx/8x5GmfXU2PZW+SL0WJABfe4kvGr+YXkfsrnF0UhAGAOTo8ZSfK1kVkQ0mTloaIyntPSaMjHixyCjsc+h/zpg8t/bS/PcAVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BN2L5sOU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I9QH8f021775;
	Thu, 18 Jul 2024 09:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	lyHDtyrv4mmJ5N8CRWKtHL2k+LJE9iDa/mi4uCgG0oE=; b=BN2L5sOUqd4gRr1N
	lj/NNfZRaZM3sJ0EApbHoFyOxLvz8/51e9dvJlPlMKrwCAn9zeLgKLaYVM8OJOMr
	W1evLMkEDeRqkTyjkkBy/YJRZjHe7IcS59PxywaymLn1STGnyLdAkHvs3b0qEWGF
	6erev9Mw1UfZz2HKg72PNVmJBXe4EAK/W4fOUAxq6hON9Lx3KUavO44DwRsK6bGj
	rcrQv7M/7WaDyr0Ankl29X8lnDMoual7jb2akkqkR4NQDBdV22bfXCEPukRUGRqA
	ghkLRX3ReioL7hEFQJASk1BnpplWKnl134nCA9oxmyjfxRY+TsgJ0qO7Byj1Fzk4
	sm9lgg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40eyjp83ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:26:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I9QG3E021735;
	Thu, 18 Jul 2024 09:26:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40eyjp83k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:26:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I95YIB009173;
	Thu, 18 Jul 2024 09:23:52 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmrw87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:23:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I9Nlxu53870890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:23:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEA22004D;
	Thu, 18 Jul 2024 09:23:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B17B120043;
	Thu, 18 Jul 2024 09:23:45 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.179.24.91])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jul 2024 09:23:45 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Yu Zhao <yuzhao@google.com>, Janosch Frank <frankja@linux.ibm.com>,
        kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List
 <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun
 Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Frank
 van der Linden <fvdl@google.com>,
        Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>,
        Yang Shi <yang@os.amperecomputing.com>, linux-kernel@vger.kernel.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [linux-next:master] [mm/hugetlb_vmemmap] 875fa64577:
 vm-scalability.throughput -34.3% regression
In-Reply-To: <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com>
References: <202407091001.1250ad4a-oliver.sang@intel.com>
 <3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com>
 <CAOUHufYvCeiGGa+3PbPDfFx__aV2XxyS7TMHMicws4aNTg4qmQ@mail.gmail.com>
 <CAOUHufaO-hxdEJZtdN-5EHEs-wOJoGQ1pVGeHaa89L7hSz8grQ@mail.gmail.com>
Date: Thu, 18 Jul 2024 11:23:44 +0200
Message-ID: <875xt3dpen.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CZX9u0F6eALlKMm8C6icAj4r9txRB6d9
X-Proofpoint-ORIG-GUID: VdC1-gG72XRKDWGg9xrl1LXn5vd61cRt
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_06,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=700 adultscore=0
 impostorscore=0 clxscore=1011 mlxscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180060

On Wed, Jul 17, 2024 at 09:44 AM -0600, Yu Zhao <yuzhao@google.com> wrote:
> On Wed, Jul 17, 2024 at 2:36=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote:
>>
>> Hi Janosch and Oliver,
>>
>> On Wed, Jul 17, 2024 at 1:57=E2=80=AFAM Janosch Frank <frankja@linux.ibm=
.com> wrote:
>> >
>> > On 7/9/24 07:11, kernel test robot wrote:
>> > > Hello,
>> > >
>> > > kernel test robot noticed a -34.3% regression of vm-scalability.thro=
ughput on:
>> > >
>> > >
>> > > commit: 875fa64577da9bc8e9963ee14fef8433f20653e7 ("mm/hugetlb_vmemma=
p: fix race with speculative PFN walkers")
>> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git mas=
ter
>> > >
>> > > [still regression on linux-next/master 0b58e108042b0ed28a71cd7edf517=
5999955b233]
>> > >
>> > This has hit s390 huge page backed KVM guests as well.
>> > Our simple start/stop test case went from ~5 to over 50 seconds of run=
time.
>>
>> Could you try the attached patch please? Thank you.
>

Hi,

thanks a lot for the fix, it has fixed the problem on s390.

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

