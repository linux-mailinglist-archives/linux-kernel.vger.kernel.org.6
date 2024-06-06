Return-Path: <linux-kernel+bounces-204321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13E8FE732
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A6F286292
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C88195F08;
	Thu,  6 Jun 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAAGd9l5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BUeJoR9C"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA7195993
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679396; cv=fail; b=pgLXNAwyJFhhbBYdwIanwbOzE5bp+YupDUcxeKWGyWWuyFqA8/WAjf+60/+m4S5XpPPgOQXJRwygZrr57BlZbjangtOQQZ82nxi/7HZkKLvwN/4/aHz9DYed4EovXQigy9rfIUM1eLHAqIlw4SXYNbEsCrFYLhVexb1WpIwWJuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679396; c=relaxed/simple;
	bh=zGGl7Ka4Blg53mk6b72bvuah83ciBnSe5kTLLLQRCYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzrogUt0q+ZdIYhb2pndYP8rpOsi3pf2z3kGoMwQ1AhMJ7epycvPAeXhezuR4SxmLBfkGfGGSpx0Ub08cjqQrOamuhMRY6BMXpwqKqVTgu6rmjbJUUYfBpt7yMNYBzrc/X2EjMFKof7rlawKHr8siWallXRPiqEd4VfRCTR/V5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAAGd9l5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BUeJoR9C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568ikBT016402;
	Thu, 6 Jun 2024 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-id :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=kY0QmRumWfnONpcoLM5xX8VEWH/9UNfJ2SjxeISvmAc=;
 b=VAAGd9l5fAhgJOp7164sKnkMqIEO4mYsFG3iBqG9l6WOZvtXzHJ0Gq+fnr0k2ySxKmRS
 5kzDhNUHy1xMdhjhLkEeOU0zz74fnx1QGuQsdPoiBVh+IxAIw0zyxX1x0R7EW8B0NeJL
 g8udEXkjsDhCUuCSyjoz6LUs5gja34o9X8hZBVmY4fPbuOsBduvMM2kF8HNMlz8DDZiC
 qsfPS/OMfnKdzIBXKfzSZDpdyGajb1mFPSc8ML2ldHazJEeGrs+ybyyECwgdDxKg62WY
 RjujbXb3vaXaxdib0m53OXDAE6Ih6e6bATQ1KubpD86IBVfLtG3S3x7bdjdeq5Jsg7C5 Ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhbfw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:09:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456BtW1o020575;
	Thu, 6 Jun 2024 13:09:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrj52q62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 13:09:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9dbzNXWhiuKVIeEfcwqood08GK4Bd1VSDmiq5Ea/UU/i/C2E4F+J5DIennHVTItrqmRJKnveZtfeh96J/AiV8Irb80XMAjAH89gNmRQiISaghAKl+shDTdX+IgeGuR8mW9MA4gRxfBLMymwOXq3RCwaeh4N+IRoRGFquFmhFv+tPBdt+arnm/IooOV+lByNuygUtDBzbF/NTuL8H3ny+jgenhE2SXXtsjW+MNi+o5unNqkpAwD7FXKBgoQWHU98Sd0JlnwBlP+GFW06Om2zLWiVtHGQ/X964/3ttm616caXvlQPIH5JwbBFBmhDljN+vyoDXJFXY5PjR1tbTdq/sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY0QmRumWfnONpcoLM5xX8VEWH/9UNfJ2SjxeISvmAc=;
 b=ZhbXd5IWgFY5Z5hoIEGn81Iic9wswK5f5jjHBFzDaMrX9WpWP/qgA2/VoEzJuDLKcYVVoFPMBwLeK8n4LPavYXeGMKudgqgAjmwxGKqrEn29MC1rEZbyaPXHouxxwplWUI0Lhb3J30tekQ7Q0W9vAdSmZvqN6AwMR9it7T5vsCyBVJB63Bmfs28x3T/fxiIz0B8YNsBtGTAjfLptGwp5ElfYLad1PvyWCp9bERAjLws/j7FCtO05qrospV3dbHlhr5UP1NrqocK7RY0/solnKkb/eg7ErNqVcXKOLr+mMT4R8xF7/mscNgEiQ7gPovKFuNPOl1Bds6O2G3IExCkyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY0QmRumWfnONpcoLM5xX8VEWH/9UNfJ2SjxeISvmAc=;
 b=BUeJoR9CprpCLiFzIWXDGEe2ZlMdJ7MqzcZvjb2DoIXVzV5APp7rhZlHDwqv3x+fVyEyx6ifJ8osa2QO7EBgxUsPE/4hiJJvPbeNVFv2B5QaoO8HVFn4BxgzkpADnwur3Pe4mYf65ExLoK7D4OMtgz4TQ4C+Zb15GjFxlAZAlIw=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 13:09:08 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:09:05 +0000
From: Liam Merwick <liam.merwick@oracle.com>
To: Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Thread-Topic: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Thread-Index: AQHat16AfUfRuEzZ0ESy4bv3kgU/FLG6xymA
Date: Thu, 6 Jun 2024 13:09:05 +0000
Message-ID: <47f963f7-86ee-442a-8446-bb40b19869e9@oracle.com>
References: 
 <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
In-Reply-To: 
 <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-imapappendstamp: BN0PR10MB5030.namprd10.prod.outlook.com
 (15.20.7633.033)
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5030:EE_|PH0PR10MB4600:EE_
x-ms-office365-filtering-correlation-id: 87d77e62-b6b0-4426-c842-08dc8629d831
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?RX+oeGYwEMS1fTXHYfRR+k4bBRnVsJ7r94elrnUvzQ4z/W4PVgv/nycH7q?=
 =?iso-8859-1?Q?CgetuELQZMcOxDRGWYWXw0x5ZEcud9eCEEAwdHH7gPrmw4ITVpuEiyezFV?=
 =?iso-8859-1?Q?svUKuu5K0GmxOVH1nJS96R+EorUPTiZpTWB3zeRbBR30UMhKN8mqFaCTes?=
 =?iso-8859-1?Q?B/nKS22amzHzIH/QVjwBOOEIFese0dumXOCGuXuOeb6fivieiWOd5ILo+a?=
 =?iso-8859-1?Q?FhGoAUImQR/YYkOJNtjeYqevLLgn++HiFzxIuRJndN/m0llIPENcuY3BKd?=
 =?iso-8859-1?Q?3cM3cl5aUQ1Db7dL1bt3dU2aV93rEJ11Zp/EhhOMTBEHbYywwAzrHWufyq?=
 =?iso-8859-1?Q?V+wP80As1AaYeHl3fi7oySSdYY68qBwGBCOn5gnJazu7Bye8/jGIBcdM+D?=
 =?iso-8859-1?Q?/WfybFdbSPBkTYmCpw1hWp0rjZ8gdeuugUIBrGa7fElRw5TiHzhnMWi3Em?=
 =?iso-8859-1?Q?hpl+1R5yh29DbzjXUnTQMzxrVwWwr+Avo8AbTQl2kFUU7ZaG7tCTo0FZJz?=
 =?iso-8859-1?Q?aH/WwzGog+7KYXdnIkYM0tRx5BdFvwVimAoD5E0SqN92PHWseFi9k8Cf2e?=
 =?iso-8859-1?Q?QK/nNK+y4zYOmFY7TUFdJmwS2ux+9ea3DeuBQm/dD3HDAtroaiBEHwjKw4?=
 =?iso-8859-1?Q?WHAJ7W9i69rOZ7LMZGND23lU41RMrci3E51azQ8qzYSIbw0HZQsHxBQ/Mc?=
 =?iso-8859-1?Q?GHncR6ykxt7LZeHZ6Bl8D2qiCqOXdt9YRQ3ra3nOmusnJrpYOiDtWol+wA?=
 =?iso-8859-1?Q?GMc5cHVX+Us44Qc+vT18RHrxIumdhCVRfstLBveA9/Zaq9P1/1yt1nWOXX?=
 =?iso-8859-1?Q?ms3WlxiSyMDayh5ADhvMsiqHAVOzuZ2wh0MxHvbIZr2HFdvLSQhDJ9LNPz?=
 =?iso-8859-1?Q?7AfOSsOHLQEHBQgXlXVqeeUCGJdBrhPa5URfGFzPvnw/z5xsmHKLMlOZm2?=
 =?iso-8859-1?Q?hUrhbShBiCToLazZTBm/oPirkLPURndL5wD7+smeu/ptJrgPH6xjgqYFoq?=
 =?iso-8859-1?Q?bWXx80QGPV5C02ljrxbHqoAVd1+HXAMKffz9K+8hPNr4JczzjcgRkZ7f7f?=
 =?iso-8859-1?Q?nPhchNtB/MTG/RZElh6bBe2/z+MAkEA4U557crFgFBKJizWeUKp8t68CzI?=
 =?iso-8859-1?Q?Dl32g+POvCUjPLvB+XZivMZmpObpaPeIEn9QkgWbGDTbHnGRMf+JsESZbP?=
 =?iso-8859-1?Q?y1J9f0XzW3CTgfs8NwhcI+eFs9aL0Br7crPT/aCNiXRv24h6eJFv80hFzu?=
 =?iso-8859-1?Q?/n53twLNI0HBSsFCxUeIMPyfnmzHbrinRfDysUyEWKh12WWFKyq4Bs0uIO?=
 =?iso-8859-1?Q?fx2mQWzzsLR84HIIhBeu3yYZjQ2eb3WuFa/5GsNzFPTw47M3gHWjr/yJnI?=
 =?iso-8859-1?Q?rivV5RqpC4TX34A/mJJC1OA4isyA4VcTAcH8HdMuGPsSnJKXmI51U=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?2vvbRPjoMgShyeZJIPx/HmUUehIytj8ViruUd6u6pn3fQiNneWRnY4vyTa?=
 =?iso-8859-1?Q?s8H9CULyzNoe5PYJvmt1eoBIMV4lXvmGs1ghwLxgC+ndKqcHmO4e+M8jot?=
 =?iso-8859-1?Q?vnqqR51N5IklI9IhvhfmDNGv3KV4vzNYDG6xDQMa6c+mIV8FSJ6eb481qS?=
 =?iso-8859-1?Q?5F2GfwY+cUiVWTm//9y4q88msJ6s/QujZXwiUPi2laBh/rRg8lYyZPqX+C?=
 =?iso-8859-1?Q?g92axTTTDdaw9BEHyiUnC/RChBrRA/AA+5T7yXysYMEY+aoJRROszLuSn9?=
 =?iso-8859-1?Q?iSmTFKTFM9hwsnYKM0mEVX6cT5GcUT9EqsLyz7aAy+nM+k7+zX64UvXmVG?=
 =?iso-8859-1?Q?EuljcFSBPcUSjW6zAAmpyzFtcpCt/DQBR8E0tcyNE5f64MxXkkkq6gR2tL?=
 =?iso-8859-1?Q?52Vx3LkiETzkKMjpkfsFx4HkbHPrddzaBVH9LsbCuQzY/dTipTmM1ZUu+9?=
 =?iso-8859-1?Q?RLDCb4edMD0Gs6IbZ2e7KX9Cuwxbf3XHi8U7xtsvuIVrsfHNqzwuii6RIS?=
 =?iso-8859-1?Q?3RLKyXa/sMjdApj3+Py1lUnjSlxE/b8loJPpRvwnkDt1adBbXF3bCI88xA?=
 =?iso-8859-1?Q?D8WnRMvj20JCeV7XbKh9TqWTrlTJPZC9WJFI1kORuIdb2VU+BY2MktViW9?=
 =?iso-8859-1?Q?tHFUf9AA6JoqhVHnqpBiuT71xR0b3K7160esVvtwDo+rF3C9jsKiIGB0JW?=
 =?iso-8859-1?Q?i/lJaFNYqERcLj2sGBgr/NRXAzmfR3JORwiI5SA+jW4mAZ78TPs7VvDKto?=
 =?iso-8859-1?Q?jAfgIt6sovhFUoAnuNN/HuvifW/ZCa4LKIc44w5HMBr9tQHsmDTgHA70Ch?=
 =?iso-8859-1?Q?LdZYSxwMQbWciWN4AAi1qZjHILII7DhNhb/d78StF08DcPo3KaYFku6lZg?=
 =?iso-8859-1?Q?J07GIM0Fz+QHCv1HxKb2ofWsdQS76CSbtrmCxTaniIwhukr3sNmHY0WLM9?=
 =?iso-8859-1?Q?ngO9H5s3c7xucvYN4zFuy2R0M7TgRq9+PJqLwCfh+p36BEKNMUzYuHuoDu?=
 =?iso-8859-1?Q?bid2FSdtKFqhG7bra/snACbJBzvbVmSeQHBVWj+9PHCcCK0FnXBcY3/nXJ?=
 =?iso-8859-1?Q?cecu+VPGmsKp2VuRxejKBO5FLPJf30tI2XlrdIPZhPhJ4jA3xynseguIa0?=
 =?iso-8859-1?Q?m/oP5552gc/qT1U/3U0irwyoIBTFooafqjz0p/xBKkOGz5cfxSxwXPyB7S?=
 =?iso-8859-1?Q?wT0hCZMQzwvszF7BT+SIMYGFW0DaeUPhqvPf2xmgUJ9b0H1xITaStDEhQu?=
 =?iso-8859-1?Q?fjVporSM4Wz6ZfgsLs0FfktIg9S5fhyyJKfF4UEu3Ldhpij4egl7/8Hsmj?=
 =?iso-8859-1?Q?pnbstXtN7LjUh+TrQ00ifqznbKA+PZZX6C71dilKOoiVB8OkMV7XJkbL5+?=
 =?iso-8859-1?Q?Bcexu8NQsjSREvEdRt7e5dlKJmQEQCG42JZLucgLf0dAOpltcFHWYtJ+8d?=
 =?iso-8859-1?Q?eOKojpYVJ+HayDSBlw0W/XPJ5fXSQsgHLDXK9ybrGgRLDHd4cdUIsiNRGB?=
 =?iso-8859-1?Q?qCuLN/NKNtUmVCWN/kakOfrEBBFuzciDpaH+FMoxnmQsG6qpMNi4lOE1kK?=
 =?iso-8859-1?Q?oXmQ/EBsmbR2ll9N+JBfOSug3gnxQdmE+gIzmP0DtWNpqOyqWOkTCwp5Rd?=
 =?iso-8859-1?Q?8vv800iV9TUwFEBTuaaiLPcRy5NW8PtHO4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <02055DB9764C5545B30C3F9FB99E390C@oracle.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	W35k/XISPJClmo7lwqRNZfMgTNTzlL2smMtmORB+y7yXEDD2Wy96hv+hQxM4DRdeWcnCarKPUOgW5tg4jR2cAER072Gci9nWsNnFh7G/mvaWTNN8o2tsULDqT171Go3kymbjeSLmVSVWYKfZX/TU6t/YlNW+wIebY3o07jE652s/4DydQh87aBRm9Qz4a8zbzkXSoXQ8dJ0N9k4i2s9IjBUVbwK+gbNfWxDvxpKb4aLK0rsPY/n6dpsnl9ublS15Cxe7te48KJVNCdmEqMw/e3o8IufIGPerP6MrHFQstbivCV4EYXhaj35kfS4IFCCtbV8FQChlvJ500G6xdpQSThK7tymkbDY8n70xzkVvXmlDDVqFnLmUcqcIckhO8+At8e04kSGDOZeUa8UZyti/ABaJqcIh9g0SxoWn6P2BMCARK3WpjI7M75zd6oZDLHJCUwdb1lk4XywvkZeK8cG56IdoynmwLJ3gUmo0Oy1+bZdXtTNyu+025UcIfVRVQVTnDsQoxJih/vLKrM+hkVtYXFa2eMeqtqToe3HBuaAJ7YzxsVq8pethKPLs6t3xtvO/lU50ozGIoBK/CUFyV2ZVgKkFX2ZK085nSBuzIXZSFKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d77e62-b6b0-4426-c842-08dc8629d831
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 13:09:05.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upKX5tD8zfsXZWhuMBYSk4LhjMjPs9MAi0MSSm+5UDVo1zUGFDlM4vBLEyG+XivP5kGeLuKgwcm2uxVtCiOPWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060096
X-Proofpoint-GUID: ryOKzenb_6SkhTMkl9OVyfYKlPT-dqBr
X-Proofpoint-ORIG-GUID: ryOKzenb_6SkhTMkl9OVyfYKlPT-dqBr

On 05/06/2024 16:38, Tom Lendacky wrote:=0A=
> The RMP table is probed early in the boot process before max_pfn has been=
=0A=
> set, so the logic to check if the RMP covers all of system memory is not=
=0A=
> valid.=0A=
> =0A=
> Move the RMP memory coverage check from snp_probe_rmptable_info() into=0A=
> snp_rmptable_init(), which is well after max_pfn has been set.=0A=
> =0A=
> Fixes: 216d106c7ff7 ("x86/sev: Add SEV-SNP host initialization support")=
=0A=
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>=0A=
=0A=
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>=0A=
=0A=
=0A=
> ---=0A=
>   arch/x86/virt/svm/sev.c | 45 ++++++++++++++++++++---------------------=
=0A=
>   1 file changed, 22 insertions(+), 23 deletions(-)=0A=
> =0A=

