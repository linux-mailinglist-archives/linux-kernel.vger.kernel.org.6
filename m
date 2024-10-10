Return-Path: <linux-kernel+bounces-359718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBC998F7B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78EC1F24106
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A01CDA05;
	Thu, 10 Oct 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T0OIBMTD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lN56mJ85"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CA1CEEA1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583840; cv=fail; b=L/BsZ71sR65l32oBW29UApZA+irO+oCTqi/fNTdUG9U1AA8W7Tjorm6JY2vImSZYnK6u1jjKEXybSiRRrWm6yDxuBC5zb/sZsKXQgADKTPU731hnpqfycBRJ0uevz3Veok0ggQ/BhGG5mCfcs7/+34aIzP3U5ldqWSjOIKv6liw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583840; c=relaxed/simple;
	bh=1EUG0vR9DP3IQC7F9WArfJREOXgua4QevntDxiszUkc=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=onz/jbGD0dfRdQvkcPI1yxqbKC9trmdEtOQr8AJ6l0Y66lGCSbI8DhfTchv6Gup2J1SJ4eqDqKFBcZOGu8SJl//x4/RzeXsfONna/58/1UoVzhaxK5RS5X/qR3xpeqvSuvXYhvAHjgeqs1lSDqOax4y2AFh91pgm3HTHY64ei58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T0OIBMTD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lN56mJ85; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtdUw008799;
	Thu, 10 Oct 2024 18:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WhcZxzQtaNbWiQptrM
	yfESk43wdrpS/KBqABqFmttoo=; b=T0OIBMTDtEX7Occ5iMN38nVuyKbPLfaif4
	UeiHaa8X5WcoQitxhLn4m2kfGVY7c0TQmmxSXfr2HGpJqeE3Dd7VEMZvyO3k14P2
	vq8jlpD1xN/NmWMSCGdTccNGjLAYoJ+N6NM1szWRyWW0/bSyGBq79g/BJE5v00mt
	i415NvrCd1pqmUcqoDueUq3nPzZ+57iHYdypV2YoJBLt6LgzXfQ9ZcAlOje9011+
	Ja0lK4Rba+xkWGe5Ix7E43LWCP31imc4ibwkiuGUojQcuOhzQw3F7zZ9NRahRqPb
	S+bTeGM4FiwjuVZSLsT1N92T15tJVBeGPiOWxi2r7aSTTSbU2FXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ykd4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:10:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHItqu027716;
	Thu, 10 Oct 2024 18:10:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwae361-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d7dcAAeka0m8zh9nq2uBobnLCj7wZ2QieXUy5IPD/YpJ1y2zvPCTXnn6ewlt78sLxCMASCIyUSjQJqfoY+mjkeN4BpCmr2pftYbnbgWvJ4AQdQpmAanXkkWLIUyKST9HfgrYPwcbrahR/JL/livDpPwviNbYFA9zC39toFBhnbYFovixEKTL6hYg5dEwH2XXofDzXYlAwgrynNFYiMh3StNRrGYYr6i3DuVE0GGAo0eL3bSVZMcPocds9uggJcQDQzb6IbaX4wLrbItKvmuSaEzK6fIxpsppw/iyGlbwTd3uCv5jAPjwVCcMk7tgBIXQV2tPBVZ7ga5DQ4bAzphQOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhcZxzQtaNbWiQptrMyfESk43wdrpS/KBqABqFmttoo=;
 b=jrKpkun0M+cI9IgZsFZzw8vwtdI++7bbeorkECTOaaHntKRe9JxELt8gIdk7rQcGFDW7X6aj0joASh7gHAiodFo3zk9ClPGde3GAlsyfRetRkYYB24twTnAfdiTRv9DvwcFUAGXLwOhiAppYtWurch360z/Z9IVz9vHFehaRg4sB2aM2OEZ5migYc8pVK0iCZVmoauhUSq2uKkE8HuYBEwJU8V8jXHdBjmkayBgcXGC9WvZEVYHZpgtIlx57TDoC8oLFX13Kg8w/4NQ6XeFAQUsuNztblFSKjrtWwMPRmKpwf6ilENLHdH3TOAHiGoiK4E9PDZhHr+D4QNKQH65hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhcZxzQtaNbWiQptrMyfESk43wdrpS/KBqABqFmttoo=;
 b=lN56mJ85itJRc8NiWerxDnUBozohkZZroD4UcttoQIwCn/2yxnIlQPchdMvJACDxJ0k/LBttGVfZ5f5F0SEGorgEqOwq0r/hxIvGMfcluGlQWCCJjF3OmyzSST82p1YXYWQvqqY8JfPif0WgOGOL8QDz+nZt+xNKLqiSgdINO/Q=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 18:10:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:10:08 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-8-ankur.a.arora@oracle.com>
 <20241010072221.48wfFV7I@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de, sshegde@linux.ibm.com
Subject: Re: [PATCH 7/7] powerpc: add support for PREEMPT_LAZY
In-reply-to: <20241010072221.48wfFV7I@linutronix.de>
Date: Thu, 10 Oct 2024 11:10:06 -0700
Message-ID: <87jzef7rsx.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0111.namprd04.prod.outlook.com
 (2603:10b6:303:83::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: b03cbd34-7eb9-42cd-94a0-08dce956c604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7agNGuuhC99IOuI4j0BQ2N5ZhlzjuC+UF0y9j28r5LfaZ1kOSnk7zh4K32jW?=
 =?us-ascii?Q?gG5SrJIfYdOoB/nZOzs52KoTKxwpKSfqYf4HG6zWY9vZAyftT1KIxjyKXmSg?=
 =?us-ascii?Q?soJuk5/GCIKJ2GF5i3G4KJsstchnT4VpkUvvuFCpMtfW/bV78SL16DDKnchW?=
 =?us-ascii?Q?/n+w3+Z3LZUXssn6ZYWO2woam38no/ihIlE/IdS4DOQ9ytdq7CPV1FeVd64H?=
 =?us-ascii?Q?L3oq3TSGGZvvz33gButXzIgyWVqnFl4akxgD8cekw/J+4q3cn5Nau659yDaV?=
 =?us-ascii?Q?/WqaaNVeyQDrOpe79jeHi6JzM7iFWv9qw4Rbh3M/PD+IupEjoEVT5ebPMVOW?=
 =?us-ascii?Q?fXZycK3fqUjflGEy6c0sHYFwxXanRcBbQsza/vbIaMaMAUhHh/Qm5OF189v6?=
 =?us-ascii?Q?bOxSfAauo3Bi/rr6V1eczpwfd9GBJ0vOsXQ36ktB2VzJj1moqH/4GdyhIqlZ?=
 =?us-ascii?Q?zAiefkMZvL1O7JECoVTfYn4wY1MbF8jIiqAe1dRU3Li4rwi2RdR+yofKQKRx?=
 =?us-ascii?Q?rbb08rX92+XiLso1V1ECrDi/t293HOFFh1TiKpgdDKxXQH8kX3pKMd6tI6Fo?=
 =?us-ascii?Q?AnQDVa2AoO4PzHyOpQbFG8WBDQIv+lIDMOnfVscn8Wi+9GQdKLPMkfW/3olc?=
 =?us-ascii?Q?QOPFiv7vCrcAictVe+G5ztp7UWuYUeZVyeeK9zkkEUmltvumqF8+NI7wTIiU?=
 =?us-ascii?Q?ipBCzPwB7Ot+P4vPH/1HejgS6yJYQ1lGcUSBzGSJMI0IKbPLGBJT9M5Gi7oF?=
 =?us-ascii?Q?3oaYCJVqeWcifKeyeDTmVGAx8z9kpre1k9biRYMQlFKHa/PchtHsS5vuNN82?=
 =?us-ascii?Q?B7c2EaokHSOW9g07E72Zmo1r8cltFF40ae8M+XANVMC203f3k0DcEAzyNfuq?=
 =?us-ascii?Q?t8zjdWr32MECcN7Uerg/qVWi3MutQErxreKVanI1vOri8MAiYm5aa/8RS2L4?=
 =?us-ascii?Q?OFRiKPNyGGaj+oZN5ttssaCLT5/e1FvADru7Tc3uIJBRMngtPVDEuEnBvOC/?=
 =?us-ascii?Q?jdaLed+4Zx1D25smMzvtBwvTbYnqRFux62BsBqX1FQP5XmP3c0RczAurDs8N?=
 =?us-ascii?Q?VbrPdu38ToDa4ulbmo7j8OWHSqUVKkD7F6rHSC9MJpwVmD+1fXIN1keA4HDu?=
 =?us-ascii?Q?yQdnum7PfDnlGvCxejRBdFpjZxWRq0S1F3xk6fy+tkL0MGPs3YyzY745hQhA?=
 =?us-ascii?Q?RQbRg0SA0VYNw0s5+FivFR6Q5TBFQ9pufZ1ujLIW1OXcyGCLQ73K8huoXiAt?=
 =?us-ascii?Q?BbxvvYwqRSLDHv0642CEhV9IedVk67qyS1CR9hWIfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fl/Iik1mRWFbwyaBdkngojja89eyJoVDFmCJgYf3yVNCxE8qbaS4XEE20eRO?=
 =?us-ascii?Q?kZsuy66cVwJXGlqVUt3G+tmv1DfzpkvGC2BglZz13qQmoL6TuJGEARuq8bkH?=
 =?us-ascii?Q?nYj0DWmODTtQnHhIR3+Tj5nVgdgFOcKrJ6JrWM22ZNWC4p3nvCZs3VvKQ5cV?=
 =?us-ascii?Q?9uQSG1+tJVLEharQZWzU630HXki6MHNOCXPAzr9R8u3FxgpUejdOGBvsPN6y?=
 =?us-ascii?Q?zEgt6svwVdAINVaZI5G3JNtyV1jbgc3Q9k7QNn1i2sWpzOd4wu+3VuQNU6It?=
 =?us-ascii?Q?zrhIEP2s0Oqz1GbkbTg4pzog9KjOEdK4By0XI204LL0corPKSmup/ja5c6sc?=
 =?us-ascii?Q?pPDB+U+lFsVNya9j/wvoCJSb4xptITks7/bL3p1rKB/BlpZEiHWSJWXfXWTf?=
 =?us-ascii?Q?7ufK3jeozhL7nDf3c66rpLnn4USDzgIQUwrCnRF1m1zZJ5uEqG9kiieFsGxf?=
 =?us-ascii?Q?G4fla5ENkKbRQRthLKSv3sXpFdCrKuX5dIWTJF8mD5X4GGVaI3FFOGDuB1Cg?=
 =?us-ascii?Q?aDDDdb4lpv0w8n6MyuhJcrB5B/is9wx7ET3QI9t+sxoPR7B65p0wd/FevAQ7?=
 =?us-ascii?Q?Ii3lovJdbHYOlJ0XAO6JLOZocz/oQYlZ53c4IvJr/yVQE5C3FJ9z0ySPvx6w?=
 =?us-ascii?Q?esEL2wpG6TSQKmw7pqaiws2JRhpqF39LS3vA2/CawD5a2flEJmD+h5OabsLg?=
 =?us-ascii?Q?P6TbAkbipWt/mQLYVVuNKwJXRX+P1zqpLP55Rq+05IqhL/jJ7BODcfvDuF+B?=
 =?us-ascii?Q?DWSaidFZ+D4rTeTNMNJJViRSkCPbE/DY1Z4S8NzWK9rUSYblaix13SkLY8r0?=
 =?us-ascii?Q?BPncCd5JjXEdZXiCuCDgmIU1D4H8h3e2ITC2Dmx3J98D3uQC0ez8ts4V2LNL?=
 =?us-ascii?Q?BBdFovYnqBbJX7NMpszEKH6tdd4tJfM7EMXwKJLHY3XRKIggkNUMtvBnFVKy?=
 =?us-ascii?Q?JSeQMVt9VtCGGTjrhZXrSRHZnRAmCfSBz1rg/oSa4OyKoc+QO64l71TT9f5j?=
 =?us-ascii?Q?9STHcPMebzbOTjA4GymoLRZVDGEXDqCIcwzmR1KJD2zt+F8xnqkfaEmh93Wf?=
 =?us-ascii?Q?Shud5grghDL0kvBcCiJ3CQ6TpEhouL5kImK438NAY4cRXO2Zahlnk6ktWHY2?=
 =?us-ascii?Q?Ar6BcPCW9jfGSB8LeAhs511I0yFEc56UNwcJZpiN2Ng2+pscIZ0/Wp6NZ41B?=
 =?us-ascii?Q?RQJe8cd9Bteijn0O3tFA7brudklJOaZ+FB024RMA4Ysi1giPLttjVAkS3Yak?=
 =?us-ascii?Q?qBGupLLhJfpCR0T532pQ1/7v+iB2+dgctySalpMfCipV6sPA1WGHORCI3n5U?=
 =?us-ascii?Q?OTUkplMHFlEd6rYCDZFaBr1Nx/WgiVpeKbw4Jex+FJDM1PgsLNS2OiB6hvCg?=
 =?us-ascii?Q?eQ5pkiN5C2QvIa4+UqGJBf0UxBHdv0tL/iNfqqhwCU9d3KUwDQQncWkib0OF?=
 =?us-ascii?Q?LLuGnSpFiGG/7vsBIRHyUE0cu50MfCVNb5kRlc1KttcJ4TXjlyyYem0LYh/Z?=
 =?us-ascii?Q?Sh7IrG+yf97aPlznGLGGpF2CF9dvplrJsakwlmzzAxLHgKEsLY6dCnRT4aer?=
 =?us-ascii?Q?7CzigkaRGuU11DivntNdbXahyCT23rF2xOq9CDMZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1LDZ4Q37JmKgixH25pnqr0bB3xm21HXEfukxoBUckD1ZLC2wm/7yP2GFTdktxzsU+3wcjH9LMusqnyTyks1nRAx5eznoFfmNVa4dWRbSMH6DBETo4PBA5mvejXFYuIyp8owvgafKzRifhipGmgfBBFdelfJGbXbNGwV0cuQanw++m6aVgGObulgep0322ksQgCZPs0tKk+BItfd2C71VBzZYVO+1TquCS+ZmuISjuXdEhjZnRL+5H3NCFR7gqYv7UymP5bBEHptZYVrn8K1hV0W0SGYABLg2KGhFrtHH7dOMncvSf4TuS44wTOsdQ9k6RF7a1/ElL4Rm8vEMnaP5M0XV052jh9xtTe84rVfCTrywWYM27OxpbRbMMrYgiAS51dQg6Oy3zQ/E9FGOZldmoBmcI1UNk0rauMx0HvnLVoaxmLOuvD4BrrPBap0XlLQS0QL30wqLE1L9OA9r5RuYuk9J6h8gn+VU12o/oDe2rtuoLz4pg9VwRrjF5CbwktKaBAh+L/TLuuOrP8lWwcvjJ/JWQQFlvnzN3y8O+97gbuCwDN/ZsiQPfOv1wuHJAfA05DRlKJI3fO1lisOjJz+L0Gg1dOsjcKuWby7KpnFMXBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03cbd34-7eb9-42cd-94a0-08dce956c604
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:10:07.9825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a7A///mO1lh18SHueWN4l8D4Fd0ggSmtsIIvP9Ce9NFcvI6XFbaS7mcrEdtCgD+pqqb/MZQcf9OxEiBQisKR4Zvja9sf6JtMEDtBDKK1W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100120
X-Proofpoint-ORIG-GUID: nLtCtLQQH0Qco_Ve41Xp4xM9_leFMigq
X-Proofpoint-GUID: nLtCtLQQH0Qco_Ve41Xp4xM9_leFMigq


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-09 09:54:11 [-0700], Ankur Arora wrote:
>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>>
>> Add PowerPC arch support for PREEMPT_LAZY by defining LAZY bits.
>>
>> Since PowerPC doesn't use generic exit to functions, check for
>> NEED_RESCHED_LAZY when exiting to user or to the kernel from
>> interrupt routines.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> [ Changed TIF_NEED_RESCHED_LAZY to now be defined unconditionally. ]
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/powerpc/Kconfig                   | 1 +
>>  arch/powerpc/include/asm/thread_info.h | 5 ++++-
>>  arch/powerpc/kernel/interrupt.c        | 5 +++--
>>  3 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 8094a01974cc..593a1d60d443 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -270,6 +270,7 @@ config PPC
>>  	select HAVE_PERF_REGS
>>  	select HAVE_PERF_USER_STACK_DUMP
>>  	select HAVE_RETHOOK			if KPROBES
>> +	select ARCH_HAS_PREEMPT_LAZY
>>  	select HAVE_REGS_AND_STACK_ACCESS_API
>>  	select HAVE_RELIABLE_STACKTRACE
>>  	select HAVE_RSEQ
>
> I would move this up to the ARCH_HAS_ block.

Makes sense.

>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>> index 6ebca2996f18..ae7793dae763 100644
>> --- a/arch/powerpc/include/asm/thread_info.h
>> +++ b/arch/powerpc/include/asm/thread_info.h
>> @@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
>>  #endif
>>  #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>>  #define TIF_32BIT		20	/* 32 bit binary */
>> +#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
>
> I don't see any of the bits being used in assembly anymore.
> If you group the _TIF_USER_WORK_MASK bits it a single 16 bit block then
> the compiler could issue a single andi.

I don't know power asm at all, but this seems like a good idea.

Shrikanth?

--
ankur

