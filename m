Return-Path: <linux-kernel+bounces-220178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4B90DDC8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A601F23227
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411AA1891BF;
	Tue, 18 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SL/kDJG/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CffFvKyj"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2CB17625D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743733; cv=fail; b=QGVWRqJ7Ml8YsJo2UT9ke+R911T3HQg+iaje2K9nslrzSRkI+qrQaK0cRrSdzU+bxhJ3eJ5eRHlrhq+Kcz0pI6lLraD2w10T4R2xQTgdsWyVaMHSS2Afsst6ns/Jsggffqo5ZPQ1YWLWK1xI60SfyxJgnThzO95n+PmeHi9IHCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743733; c=relaxed/simple;
	bh=dtBq9WGoTYmiyMWU4Qtf8usZ1nQUWFOboqiaAAhULws=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CTgy5UA8VHu6vYQsY284nmDDZ9UTTlAfEP/qQFNPPzZTTyUaOuD9iLwDKubaTHi32BgmdC6tEJqc3PLubHIxNwR2SULkytsOYnsSOrxg2ibj1rPOYgh8CamrVAIxMuk9/dZ0osoFR1wcBW25XpfO8+7ldj7WtwqHU+jfjG904Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SL/kDJG/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CffFvKyj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUqx4027364;
	Tue, 18 Jun 2024 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=zjoePE/bFVv24R
	ZtRz7Vj1cqwrP8hD4pjiPYXwOVoEI=; b=SL/kDJG/zsHnvRpqgIvfM62ALf1dXk
	pP58RZoQWP/e45stHvtBnLAigJ6Ekjv2jctAFMbj8Sec1/NtR4pgSS1HrpexGAlC
	hRYfsl8JlrUynAS1LJA6WdrQoWJfiiMEYoLmXVHg6O0T7VF4wrO7UBEpAh4lQVeU
	Ncefq1NM4TFXM824jQFbpYoShmJYbYe6B5pXiOh4eDlc2iFKlFEZnT7ByWpQ1FZ7
	W5cFgPScvZGcM4LB/gvrAw+/tpASOXA6iVSDvmBFql98wv9+POeH6ep9rtBwzDD1
	kNDTefGI8tWnAMBeYTdy7DkFCzS8xG9rhW0cZEjyt9wPo7cWLO3q5J1Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bnvn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJeuRd034707;
	Tue, 18 Jun 2024 20:48:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p6p6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUQD99O6GatoQ/ytpQraMGQwUpKmTPslR+F3+pPH15EgoPSfD1mH0YSKorhvdTfTv05nrDY2dk0wjumZb7cC+w2WGs6RImkEtWBBKrXaZ5Pnocdiz5GPnZE6lMCGZ2KuuCyqZ23lKwmbaO7Za3dGT5cusejhm/87OfIww60ETtqS1Q4oaqnSyZOLTTrrykvC1T8SeGDHuNYoFydRRGu063YvLfc6V2Y0lz1UKyYgJ0+JwK65MvckrFaHwKTi0EYLoQpeC6ettPDZAOhC9mUe0qD1QLPcNxkUWYaunU3JA/lZE14x2hUzxIdn3zHfAjLjaNZL42lcVT/ytZsAo1F16g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjoePE/bFVv24RZtRz7Vj1cqwrP8hD4pjiPYXwOVoEI=;
 b=FDheGXwa7AGDks8Z9ta2qwdLo5CHYaboN5oM4Ks9pOoLRw3JyCikHdRDf/8boLz8htcNHCh43qnjoOAXoVeSIAy3GMm0kMvcZsPo7GyLAKahx8TcuTJaOkNxq+QTE40ejcvx8SGyd5Hianp5DBLB59nIlixZ1Ai4V+I3AESUXBS43g8TYccpEy249nVfIcVo0SolU5jb8phcsDLVhHbOx0ecP9b3Iv7/ST0WAFoMWK/uswtGhkpfkhF2XqpF4zfVguAR9x0zHfHo6LlHJ02XND8GucNpnPwLEZbixBtu9U2RGD1GJIOAKBQWET0s88D4oo6A9UDVSyHGDk/+rG8Dkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjoePE/bFVv24RZtRz7Vj1cqwrP8hD4pjiPYXwOVoEI=;
 b=CffFvKyjOPwnjlpbhFz1cFbqgcS0NfFMPOsXo1hm9DIOWGLfbjcSe+ViN/s2mOB3Dvhq9ruVmIsDeDpzzuZrpHJbY+rM19wZt2OvlYgQ+H0w1D9lQ68ze5gOmAK/4exy0RccKorOVpH/J05d+f3JoV1Fgju8Sz4/X8VnWDqPtkU=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Tue, 18 Jun
 2024 20:47:59 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:47:59 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 00/16] Introduce a store type enum for the Maple tree
Date: Tue, 18 Jun 2024 13:47:34 -0700
Message-ID: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a03:505::17) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d7fca5-7b8c-41b1-38fc-08dc8fd7f07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nt5/QtRCvBkQoPL/9RJ+VnuvqIBfqPlGew28tXSEzIuf7ZD4t+gBcokg9oRb?=
 =?us-ascii?Q?Fi6A+6vp+cWmGd2GFzcjd8biLUl4LCM+92KVlx4WDkSKCmqiXir9BWWRslC4?=
 =?us-ascii?Q?7sSo9ymJSjwwVlXKW9KBpNmn5kMW1xRuMoeBYSdURx9kmPgxboikkzRT2i/K?=
 =?us-ascii?Q?ukcdR0kPWmK5JEywT0cgPYdZHHqvRAzPudRE7oQQXq8gsXLWCFXBHc+cZjkJ?=
 =?us-ascii?Q?IWFWLUbBJciZF/O3CvZvUVUHujbVqXkjEbk/TAacduEeJ/tgLRqgFE/VoNYX?=
 =?us-ascii?Q?/IE5qAviAev5isudOMF0vTNJtgzr7EGpmvJfIF2BDelRTBMeGl+/5vDvzCnM?=
 =?us-ascii?Q?9w4o8epzwjbCxa2IrQNcuaHOEYPOpVmgKxl6egfBZrqZFFfTvJ2yVqrd9jYg?=
 =?us-ascii?Q?zNlH7Ks0GHdEUAM7k/AtTq5xq1SWGZd09R9mbIBFMkSKMvN32AZrKanz7rES?=
 =?us-ascii?Q?dHGVjLJN+9Q7OT/QwuiV+srrygwSEv3OmodfeNQerw/y6Ih1xhv0esW8RWDD?=
 =?us-ascii?Q?5rl4LGFFmPsNw+JExyaW11NQHGu3OGocUqTnGKwQdEbB20rKhCboUACSM5s2?=
 =?us-ascii?Q?jZiJ+dfGe5at6mLx/HQKmm78zIH6pMqqp3iXtAlCILaJpCx+g0twuVafMc3A?=
 =?us-ascii?Q?DGsvFiuwi3GDCOVsenriwauNng8A5kmlG3QbQOrONE9iP5E6q4iOgUoQ8IBP?=
 =?us-ascii?Q?O7EoTD0cxlAf6htcxqTjhdKEl1OR3jn+cXw0forZCCFv7LkdFMzrrDDirIdT?=
 =?us-ascii?Q?MrkdBzBBtleBJfg4UjuJ4pbu46WsyI9e3Et25jPR7hl0SRWKTPhK6KbWw4LY?=
 =?us-ascii?Q?Hkkm+QuIfwdWD3qtM71b/krRTMTmhpv8NNSSkG35QMHbaDjjH7qNnxHiYqzw?=
 =?us-ascii?Q?EDd4fFotXZy61EaMw5A62pxf88YnZv/THQH4cE3Kmmaxq8bcIh3kQkOlJRvt?=
 =?us-ascii?Q?EyMJMVBq3qKDv56gSKxc/0gyaukIKB/NGdoww2g27W/W5eryMkdfdvlGlSVQ?=
 =?us-ascii?Q?UPuuLgq3KS09op7hjwXqdgJe1p8R585XelF8RAP4/pj4T7Eq4zrY7Volt8oa?=
 =?us-ascii?Q?u0F6e/A9ya6B6A8/6GrN4O2ixp4gO+63O0N0D/i3Ns3OVv5n2WJLodbWlRpk?=
 =?us-ascii?Q?MWvEa6b4hKPLbmzWHK/nMfIxACTGCn9w7OHu7t1rQlGVsa4VZ0IAVetpnVro?=
 =?us-ascii?Q?vHFtaStBP2IsRetbOaSvpe+vItECxWxVOv/kUBBPJBsw6wsGp6RO0GekuAr9?=
 =?us-ascii?Q?H06vRenL0hzArkqmL7ubWG+QEOBViwHiM1beiwGbZg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ojq7cz5TZp0IEeLMuPK/FLdeW98UgOj+bES77KW4aaGLxkBvDWOEldhSKYMZ?=
 =?us-ascii?Q?Nl1C4vS4n2G4gTJxCJpnaEXUdpRIQgOL0nnKP7BZ5KaAQxk1kzfdWsqx+UYP?=
 =?us-ascii?Q?CYbg/8ZrqakNlcV1eG9wUQbZJF0wAX6pV7J7wBeSa135S4yzbfcfhcY23KNj?=
 =?us-ascii?Q?rdFwUqHFwjWphYLhs382Wl7BZHCc/elm2lJMZlyO30yRmlmuntC9nwP8PINd?=
 =?us-ascii?Q?NzYAYh8cpLIcZ93YmpuiKs7ovJimK68l3f0qS0cOFAvqAEUcGWu31DnEv44g?=
 =?us-ascii?Q?9got3IFtgccxYQo93Aa0mCzIBfS9aEV3q/AOKwAotTZ7vQte75eYN9h4IPlS?=
 =?us-ascii?Q?VHP/TAtPd2GrHUdV14hL1evvyAgbCLu/Lb9/vwwjZ31AbTYIDWQkXO7tpILI?=
 =?us-ascii?Q?rrm1+kUlLjLG/J9L11t7H9D0n/4abtMhiCs+4HdJ25ub8wvdH2iQ2hsvnUKs?=
 =?us-ascii?Q?3co+ir9Ipg0N2zhM74Q+UHn/8Gr3R8MlbnILMeV5VC6IXIBRc5VroRX4jfRE?=
 =?us-ascii?Q?VmwDNM0OvA2E1jpOAL7nmD6SzqghdBcFXBm+Cg2Y/6CPxjkCdMRQYAChiIua?=
 =?us-ascii?Q?5OaYSUolXvq9mQh2wzBnnZZXDTpof7x8tmfNbS0Zx/yjWLurwYSKiwejq3kC?=
 =?us-ascii?Q?xoGz9CtupmUC0u3z4ZYLja+SsMVbN8r+C9N/KfvSH10weDuFiqPn3SU1z6jZ?=
 =?us-ascii?Q?5gzBodmxe5r3tHS5MM5BmKvt3ftmZlXlvjPdSt0YBL6fHfelnzQxLBl0QAcn?=
 =?us-ascii?Q?A10eTad5u5ILMp0BGpkecto5jrgYyjpFAb+QYJHITwpDYbCd6nDYeWEijBgO?=
 =?us-ascii?Q?sgavZCmmBdw923ZFoHTmywpy32wot47NjsmqxZsMmlAm5yxkvAL5KvN3XM3u?=
 =?us-ascii?Q?1PBhiKb/RNtWXiPfi8Y63EF0CGnralPfa+2NGESw0rglL8wdUrRc44j0StJz?=
 =?us-ascii?Q?XKYbQb4RDmaRyXyweGaKVnqs/Hx67q/04KOCo1JSOsxivN90hUTTo64vKF06?=
 =?us-ascii?Q?g5UEmBtimsVKiVl4+ubLdGBvgg2gXMnY9Zb7rT4JIHg3H2tC0r4WBYspRHH8?=
 =?us-ascii?Q?fDJjObuRfjqlfNRtW9ZsgvuzrXqxXRqx8PiHgP8iDKtlgx5ApkaykiNUPmYS?=
 =?us-ascii?Q?wfwJhr6ajKv3ze1xxVkUHyrvgxGJcTc23ri17R5VXCOYDI86IMuBWh6LwzxT?=
 =?us-ascii?Q?r/LB9mB78iqCt0bD1KKw+aCJIfpSq3fzlVhxWFRodvsiysr0KASCyJ4aljFJ?=
 =?us-ascii?Q?61WbvlkclbfazeGaO6wg/vs0nTQKXRBfJ8YKWOv8/QnqpifD0fAARturobZl?=
 =?us-ascii?Q?bO8dnB52N13ibFt3ndIaFuYsAlMJSpMtrLdD4RWyyPdq3hB0/+pKBGFa2G+A?=
 =?us-ascii?Q?uz/2Z80mivgySIeZJiuJyhDg9oRI91NUKftxx5z6sqglVQVjXf5VXhrQl3sI?=
 =?us-ascii?Q?lOemyAyHIB59KryAu2H3IgddmECFHroKe7TzrDglvwksopO1kyTXeXBuNS9K?=
 =?us-ascii?Q?rrmT48X1RbjGHaxdU+QPj26vQbfyHP+0BE/XrVux0Ikq9Z3jioacWgCCIDx8?=
 =?us-ascii?Q?P0luNe+9iNe4OHOQs6onyT3iaV/wvZ+VyL3mWCULP5pnpyfkE8DKXhokCb0F?=
 =?us-ascii?Q?+KsJKGO1Mnc9LE25OpFdJqM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ab9g+3fM+iH6o8zx7Sf4855Lu7Vwpt/bUeO03aF0PbN/uiOLzNtWsMYbloh8obc6NI1jpEFRWkIq8RxHhhufSjMDAJSrmkU7HINhcRoMH63N8NLnArCBj41zuRPl8m6+GMRfjXpMJNdXQioTHGtxeZY07bFSchJnW9CpdgzNgqCrrrnRm/TOAOgMWdRm8hEqNEjpUzruvpgMjjv+rK2dmhpd/vqfr7lLEaPK4EItnTihL88+eOPzOOWHHsvO3iVUslfj7ItDJGNdLefU7DDJUXRMMGt5iLfvb8PTVsVpDTYJc0eEqiH64A2Mg0O17IkaQjw708wjkm9WWqHnO0850rDEWXwKEu+JaS7h8c+VDMIo6BvXCzlI17BH1Hd2erzCGZEC4Zx73B8p8MxQ8yt3iyhBPgrVNpVIR8PBfBrnL1rzwbR8O+YLQ9kMCrFgJZ2r0cV0tPI0Pvl5xnde/ZmyG1PCflJ7n49b7ce0zcJr6tn8ePW9jlwAfRxkoyBiqSzgpw7D0qWDNNoo7NVRRci6bL+NIoqHOkt+i2qV9E3i9S/AM3Wk5R5D4AmlEybfB62JSg36sYeXdbrxEDlwU/k1qodM/Xq6ooQLl0HYVt5qcxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d7fca5-7b8c-41b1-38fc-08dc8fd7f07b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:47:59.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/7Z/hSdzaX3TbKC/QaWj1BaNLKTMIbvQZtc8NEtuT6rdbcEnywrhIlO0hVUSYmPatDx1YhNAsAXsB8jRYOnhLeL4q+Po/vAFD434+ebmds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=56 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-GUID: nXN-S45nK_oVMbyYbyLftAuiDFZv14mt
X-Proofpoint-ORIG-GUID: nXN-S45nK_oVMbyYbyLftAuiDFZv14mt

This series is rebased on top of mm-unstable + the patch:
maple_tree: modified return type of mas_wr_store_entry()[1]. Andrew could
you add that patch to mm-unstable before merging this series.


v2[2] -> v3:
  - fix new line issues throughout the series

  - remove use of helper function in patch 13 


v1[3] -> v2:
  - previous results were noisy, replaced with stress-ng-mmap config of
    mmtests
  
  - document function parameter 'entry'in 'mas_prealloc_calc per Intel
    Test Robot
  
  - explain why mas_reset() was dropeed in patch 4

  - add locking and mas_destroy() to testcase in patch 4
  
  - squash "set write store type" vs "set store type" into the
    mas_wr_store_entry() modification

  - only set ret to xa_err() in the err case in mas_store_gfp()

  - move MT_BUG_ON() inside lock in patch 7

  - noinline mas_wr_spanning store to reduce stack usage in
    mas_wr_store_type() in patch 11 per Intel Test Robot

  - document function parameter gfp in mas_insert() per Intel
    test robot.

  - further simplify the local variables in patch 11

================================ OVERVIEW ================================

This series implements two work items[4]: "aligning mas_store_gfp() with
mas_preallocate()" and "enum for store type". 

mas_store_gfp() is modified to preallocate nodes. This simplies many of
the write helper functions by allowing them to use mas_store_gfp() rather
than open coding node allocation and error handling.

The enum defines the following store types:

enum store_type {
	wr_invalid,
	wr_new_root,
	wr_store_root,
	wr_exact_fit,
	wr_spanning_store,
	wr_split_store,
	wr_rebalance,
	wr_append,
	wr_node_store,
	wr_slot_store,
	wr_bnode
};

In the current maple tree code, a walk down the tree is done in
mas_preallocate() to determine the number of nodes needed for this write.
After node allocation, mas_wr_store_entry() will perform another walk to
determine which write helper function to use to complete the write.

Rather than performing the second walk, we can store the type of write
in the maple write state during node allocation and read this field to
complete the write.

================================ RESULTS =================================

                  v6.10_mmap     v6.10_mmap_store_type
Duration User           9.80        8.69
Duration System      2295.94     2243.85
Duration Elapsed     1010.50     1009.44

================================ TESTING =================================

Testing was done with the maple tree test suite. A new test case is also
added to validate the order in which we test for and assign the store type.

[1]: https://lore.kernel.org/linux-mm/20240614092428.29491-1-rgbi3307@gmail.com/T/
[2]: https://lore.kernel.org/linux-mm/20240607185257.963768-1-sidhartha.kumar@oracle.com/T/#ma3795b93f9d5c9c9286291e12f089bff45b87fed
[3]: https://lore.kernel.org/linux-mm/20240604174145.563900-1-sidhartha.kumar@oracle.com/
[4]: https://lists.infradead.org/pipermail/maple-tree/2023-December/003098.html


Sidhartha Kumar (16):
  maple_tree: introduce store_type enum
  maple_tree: introduce mas_wr_prealloc_setup()
  maple_tree: move up mas_wr_store_setup() and mas_wr_prealloc_setup()
  maple_tree: introduce mas_wr_store_type()
  maple_tree: remove mas_destroy() from mas_nomem()
  maple_tree: use mas_store_gfp() in mas_erase()
  maple_tree: use mas_store_gfp() in mtree_store_range()
  maple_tree: print store type in mas_dump()
  maple_tree: use store type in mas_wr_store_entry()
  maple_tree: convert mas_insert() to preallocate nodes
  maple_tree: simplify mas_commit_b_node()
  maple_tree: remove mas_wr_modify()
  maple_tree: have mas_store() allocate nodes if needed
  maple_tree: remove node allocations from various write helper
    functions
  maple_tree: remove repeated sanity checks from mas_wr_append()
  maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()

 include/linux/maple_tree.h       |  15 +
 lib/maple_tree.c                 | 580 ++++++++++++++++++-------------
 tools/testing/radix-tree/maple.c |  46 ++-
 3 files changed, 396 insertions(+), 245 deletions(-)

-- 
2.45.2


