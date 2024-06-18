Return-Path: <linux-kernel+bounces-220168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545BB90DDBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432C51C232B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E210179650;
	Tue, 18 Jun 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boYNq4MN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLQ8f45j"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C936176FDB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743727; cv=fail; b=HQPJPY/V8inZEPdV3eVv3NZ3iOFtftUMmocA4Duv57otl/3/+vHsYUUpytzH5wl1DPn/lvFzEw2+MjMgEOE3Yn6+vYREAFsSjoWM0/E/fmQGY0vUE0U34VWLY/5Hn+p5OYmpk0N5YDtDN6H97oHfyTVBzFZgUElMzKhUw1nQdqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743727; c=relaxed/simple;
	bh=IwpaJ2IUCxxD+AQQ1J9nHRnSUn1Z6U4+gRZG6Dv/y1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7ZqPu4kL68l6tvpKSFC7FEnEfS5Ltc57aBhltuy/54Ff68TrHpv77KPth/Byc53F2eYcjF7s2b9gX+Hxynbq3BpT/CwLomW2URACGJWvN+w7vJ/5soGvGnLI60Pxp9znebRZMS4966jsJj4HxL8kbz152eTIjqAycKhNivnIYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boYNq4MN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLQ8f45j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUsVr021513;
	Tue, 18 Jun 2024 20:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=E0GVOIGhfEZhyYYlOLkhmH0oDChns675y8AWzaIQW3U=; b=
	boYNq4MN2uhY4Wxv5p477CBT375X1xmCCQzh7xnlytMAJOrm87iDI7TKk1grIWWn
	DDdeqdhgnW/2a6aggswz38uc8wVcYGqX9rg8+m+OJ2BcsqwlfQVcCu/k6VvBSaMn
	nWXk+5OvcVf1M3c3a+RdLM6oouu1NtzqrgobIhjwUy2/9sMaiBK/yWwumfSfu6PT
	lhyS1GnIIIl6W9G9rVvrOdvBdziskfZoSMEPDLKlR6QoVtg9tgBnXmMpetvwDSqE
	SLezYy/AOazsTlcrqQm3gIi+4+Cf+086i+ZWoPDhmqJDpJg6CdI1jX1FC8Ajt7aX
	6e53hNYNTPrL/OqiJ7MYYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1cc5u8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJFhpU034903;
	Tue, 18 Jun 2024 20:48:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8p72s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPtSW00aNCiIo2uu+SgBzlPNw9tkGGkKV6zTRH6eBUXVQ9kCDRJnR5hJ0GYtxad07ondN8xAtoT1R9Xlw6eDgTlx2ZlJ2JnPSifdA032FNSddwr0ux1dbiRH7e0PiTnou0hhvIjGgN2s3THCNYsVJlJcCBEnmwihRbxTtPb+bu0jbIUyWsVJMrNgaGJYp/YhbX/uf/cq7csK0yFvFnfp0V7bp/L5z0Jvv4LB8W1kWfQJP8OL3FuDuu0JvBEWxwUEoH+wP1PkIueNgY4zmfBAPRxa/bFYrPMdcubhlBgLF+5O949hgnnq2VJ6NQhD+s0UMZk38E5dER725nUDteO4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0GVOIGhfEZhyYYlOLkhmH0oDChns675y8AWzaIQW3U=;
 b=JeBpFQrrFhGCAq0wuk6Pmea7nQ6Y0Pbtvq6nJU01fgIfBM76+qIFrtXyDY9PJHTto7qJuTXYF3v1ac671glb/73/hJ5Vd1Jgm6Lrt33aQ8EMyM+5XqFQLSyiYsXwY8kEro37O3E9aqzzqIMk+iX2XHkUMBWQ2e06EMyc5QE1yZOejDwMb6pZWirctedwkfX+tKb6XXSgfx1Bh3dZ4zCv/qt7cRm7D15R1/66UlJA6IeYdVEISs/futnvVP8x5O7qMgzPYZollWqWFN/BjQ3ZoPBTh9gVaOrFPV7LLcdZG1mSNcr+ZQK91B6RK+VzfrSU+02h8c/0ACMCj4Q2oBeaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0GVOIGhfEZhyYYlOLkhmH0oDChns675y8AWzaIQW3U=;
 b=uLQ8f45jRhTRm3WtxwPCgkQWvNAo4Prc6Wu0GMOpgBuoelt/004RQnK4vO2p6sDfp4668u6kJF8yb91FtJeU73n3fGkF2LIGmI8ziHcnDJVhfD9en3WNnqe+Hbg3mgjlUHKc7QCkUIqrNiLH+44cgMCUqFTjOfpWJOSlJJcSQhw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:34 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:34 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 16/16] maple_tree: remove unneeded mas_wr_walk() in mas_store_prealloc()
Date: Tue, 18 Jun 2024 13:47:50 -0700
Message-ID: <20240618204750.79512-17-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1111f5-c4ab-4685-7901-08dc8fd80512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T+JNupauxEaQjSfYuQOaTjJA/4SKBYWwNLhN4yPCY9YAZeBgCMSFy9MuLWts?=
 =?us-ascii?Q?erzokUdohI7Sz2NWO2zbjZUuKHhx8OtgYnnHkj74mppJrXZ0lj82+5PBKDSS?=
 =?us-ascii?Q?yTs/TRvOtUor1HFqYNj9yW2aszys6vTdC3cFp4mMuZewR8lc/U/dnDutshGL?=
 =?us-ascii?Q?Vrp9QsVAjz0p3o5Iu+t3AHGY/fSvMXQwpgE38CHLTSEvNECEq+CzoQOauCTQ?=
 =?us-ascii?Q?2po/ezMbemvYOPcpRV+sFaAgUZ+6dE6aryA+I8Yd4/bOuzenPS8xINVokY7g?=
 =?us-ascii?Q?IIFCKr5gwRdOXEMjCq6k7mOV/voY9GRzUjCwtVvntfRAp00Aq7WLZCOQ1xdd?=
 =?us-ascii?Q?z4cGKIk2NImsNL/GTHf7KX0DMQf5EpX5rzwqEUsfpJOlV3wb6FsKafAbTOhY?=
 =?us-ascii?Q?aMuFt+ideGtZctfCJyu6I1Zg7XMmbVDTfkDDuriKI8nWllv1yliY98f7I6ZT?=
 =?us-ascii?Q?6n/i+wzJHlu0KT8sQ3vrF4vZbta+2ct9tWYKeC+y10lsqfhNdPIDB0af9aWH?=
 =?us-ascii?Q?LnLelO8gq5AZ4xHR/GvF28itOdZauk4oBFz2BWZ44zMUhnUgY89KBtP4XA5a?=
 =?us-ascii?Q?gUFVIggkEjEM7sEr1NT7uN0u7a19bqEoc21jFeTPZ1poPdwoNdY3UJuceGUb?=
 =?us-ascii?Q?bgkFPXO7mVgvEfjLwz7/jEUP+R8d6p9gGof/sxSZqbpKaGvNs07jsVJtornV?=
 =?us-ascii?Q?plgdyq28uUzVmlPHBJF/l0VliYr+UfHy8lAlNxv9/80Gf63BV9xyreTerxQi?=
 =?us-ascii?Q?H8tI0rjiL0TzAcZSpEsylGKMbNz8THjKi9GTPrcQfnEcm1cwdata4DcRHlaI?=
 =?us-ascii?Q?qYtAjEaMFuBbL+3XSpzWJ9OvoRKxABOoO6tSLJQMjSZEDiUbu9gikqcNFGQy?=
 =?us-ascii?Q?qjMdR4CRgXTdtgK2qDUTEeXRihucnvD/y/hG4rwgbShp0VgksQpaV6KizETN?=
 =?us-ascii?Q?Pjy1atw2fqgyKPs0Nf+6hSE0dUr/nTs/a/4NLo6I1ibLtaKzvu5YrohNStF7?=
 =?us-ascii?Q?qiU5uEVhvC27goE8movT1R8Tj0uJhzvophm4QWcpDfL+laKaDDYEXxgb0U3d?=
 =?us-ascii?Q?lOeIGP6FraOTqj8je+AEq5bewu70KCa6cpHJeOmn0tuAQYBBTMaSKHvqHxMf?=
 =?us-ascii?Q?UF75MP9+veqwvsZjrNf2sQCbzTwfzn0/h5eqVImjFtqoaTF11G/JBTmkKPh1?=
 =?us-ascii?Q?1WveGMKNUVkXGvL5SUUHIjHoTkYFXxI9na9awpSN376t/fQjGs/i3FwnajMO?=
 =?us-ascii?Q?c27kFq8tQoJTjQo9bT2JNkTQsBam+EVWlkQtH49m5vs4FGv2mfyClkB5Shzj?=
 =?us-ascii?Q?d5k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m7L/IlrfDVgCBKbslpvjaBtV5KvHlN2tQGRL4yXFJIxEdRaj/GRii6kwwU5w?=
 =?us-ascii?Q?T2XtLoR8kpcMAl5puum5sThPX1aFA3rxcqVoqmGYyDtRBkU9POhzsBh9SG4W?=
 =?us-ascii?Q?RbVxSyLC99E+QlGm0QTs4bL7Ukxgc4qdcfMFEplVwzh4IwPjKueKb5wrx7xU?=
 =?us-ascii?Q?ZwYH7sy+v5Mgb3/9547IjS4ueOVAocHbmTgNrfWD9EqsqnKnENi8bxfnrIYF?=
 =?us-ascii?Q?6eR4SP71m/ZNQCxhm6j37Lj4pVnKcNJpErQ6n/aSPM7vEazX6adRdBpszahn?=
 =?us-ascii?Q?jdNQOSu7FoKMYlpifUBL25nv1TR5mp89Q+A3RrIqjOK20nM+UWZwZZ+8NBVT?=
 =?us-ascii?Q?tgyigoth4hoznv7KDCtFHELrPwM2rHEbzjz2Z1JVxQsm8LNabRd/mvLLwBfc?=
 =?us-ascii?Q?IqSNQ5+lnuCcPsxSJT+0TXbyiP48i07FzMxi6WtMKdXNgA6mpCQVimiAr0IZ?=
 =?us-ascii?Q?NQ+iZL5W6m5AY06W/WjZ59KbcmXvacH9K79+onuI9GFfxu5Zx/71NVYww3+h?=
 =?us-ascii?Q?WmL6+eUOC4kRXUgPBhs1qguNFrYL+9aDblupWPola8KRug3zqZAi41wOtkzT?=
 =?us-ascii?Q?0iWu41JYRyI180nKzOdNR/VKUXvH070y2HhFLmbxB+hsDuGmUA6DQZ3ZLJoP?=
 =?us-ascii?Q?MNVH4ie5gFuvux2OoZ1NUYXfJjilImDI6Vy0cFZAfskcSpx6Q6rzZumrSsM3?=
 =?us-ascii?Q?S1o1AU37YSa+/7djzpkERtbm/ibWGTXB7NuC6pP0TCtIyCqGnrDHpaJo8o5F?=
 =?us-ascii?Q?3xCzF2PAtIrqEo+avrwkFTgNw2OV5LIPghNPqj+sCVl+clbImn1cnDWn6XXh?=
 =?us-ascii?Q?W6ashKrAQcJKvf6cB1EVRmqbZYh0AZV7fTgj1Etgacti2F8J7Dli/mbgeiWT?=
 =?us-ascii?Q?pRzdkMgWhboFDP3/k3EKjeLpqQpE8POT62PfLeTThPdLxXVorV5ChVVj/kmV?=
 =?us-ascii?Q?batWvS1oQmn1n7YG97ayyZaXALHXuLI+IgTEkMHZZGjjRRL+k/T8vRoXxRdW?=
 =?us-ascii?Q?sFDrKvz/zrRhUYW/cH2FA8h/Z+Xk572F6h7lP7n9cdhqyaC0zijZoIQSJoPe?=
 =?us-ascii?Q?HNbWx5A4DObLTq84/HPg87tAbKaQKOarMwcv7TT4HryV6squTOC9AvzUOK8A?=
 =?us-ascii?Q?KYJmgxkapB0pROA1IQusAX9hDrL5I16aJdTvBow3EeK30WZMTFfXYNT+YHHC?=
 =?us-ascii?Q?y0I7vMEKzKOSCqNcbJe0c0r5SpR7yk549hvyeI7RzdAOxnPzKdJbC5xpX26n?=
 =?us-ascii?Q?tImjp4oINCdy/frQr1ec88d275Fn35hzKjmf2Eq1ZO0xegRUtNRmzjuGLCqD?=
 =?us-ascii?Q?PsipEpEc2Yc8kUhmiz0AOg0vCItKkY/aQdbZtSn5c9wa6wJQNO7MORveemYo?=
 =?us-ascii?Q?UilPxakvifHc668uLHYMLhMLbeeELfA5GKyxwf7WaNgVG0NmhtRNNeloCAwq?=
 =?us-ascii?Q?mN3JUquJWiBxcHMDIidKYFwV8OvHMl41uKAGgZHln4eNgjTnGcKY75dQLoc/?=
 =?us-ascii?Q?lGPigt4HWCRiwpLQ2/RrznJhUQ4KJTfx7X+eeNnZKaOIsSBAVh535uPGhvei?=
 =?us-ascii?Q?+WGOASsiqerICqn7hYbfhJTz5rbcjjJvUSVdtlusiEDj+A1h4FkxfIhk2kog?=
 =?us-ascii?Q?S+rZ0alBR3xqJa8BcLgz0wc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	idJF2EESqEVegcyUv5ELQJ8fl7mLAa6q+Afl21R57Pf4zOUw3qVDeFyHFqPP1PgME3nGa7n5oo0E/gw3RwVXb7pT1JUO5mXO0JoyRcaA+ntLz9tQr+z4Bvaz4rRON4GskZkAtVFqSI4pzOFjv6w7yKiL5ELmG8Cyxh7GB4lnco5Tn7yt1ulnz//e3Ec1OINgekXMaV6ZRd7yNmV6nI13BKkDElXBtH9LszFmjZBcBZDajk/+4a8/mx5RsX5BveTpVieCJxD6y3tSb3l2DESxMNnnBR3mWrVtTiCtZEA59ot/5z6q4bIpxjrXaEXxY/F+g13/1UNbuGCHNVdlUgmDFHujmiPJzulFbi0bSNh2idANzKiDo5bSTZdwKSgoHuDnaJxpAEXqZ1P5RMVwOSmedguoPBhBAC70ryQBRc2NvuLj7WDnzwchDoMS+wvr0lfaOIX7YS44LB0lDe22V5EuGhMWLfKgS6Fb66RX7Xs/ZM8/OjfQ1hDGaIBA3B/1ihBIBIqUkPGr7gUzdSYuB5hgTpO0rgqAgt3uKE3p8oprIhOeB/4fq+lBM6ww4Dd0Hb0NNIjdLFLhG9QAH5+9rHemCOoMs90tTcxBYswX1XmCAZo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1111f5-c4ab-4685-7901-08dc8fd80512
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:34.2050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPuKw2g3Wcrn/v5DV3A+BeRNOONaNRgLR4d2uH6daNe5qYwSpUlmcK/cBayKQtvgd8HgcPoG/8aSZF/TxbVVE/ATqmBQKZUzU/3i6T9Fb94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: 4K9HPRc4i9ptI9TLJBr2lDursMnWy7Mc
X-Proofpoint-GUID: 4K9HPRc4i9ptI9TLJBr2lDursMnWy7Mc

Users of mas_store_prealloc() enter this function with nodes already
preallocated. This means the store type must be already set. We can then
remove the call to mas_wr_store_type() and initialize the write state to
continue the partial walk that was done when determining the store type.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f6a09bb7b291..634d49e39a02 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4027,9 +4027,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
 	else
 		wr_mas->end_piv = wr_mas->mas->max;
-
-	if (!wr_mas->entry)
-		mas_wr_extend_null(wr_mas);
 }
 
 static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
@@ -5590,8 +5587,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_prealloc_setup(&wr_mas);
-	mas_wr_store_type(&wr_mas);
+	if (mas->store_type == wr_store_root) {
+		mas_wr_prealloc_setup(&wr_mas);
+		goto store;
+	}
+
+	mas_wr_walk_descend(&wr_mas);
+	if (mas->store_type != wr_spanning_store) {
+		/* set wr_mas->content to current slot */
+		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
+		mas_wr_end_piv(&wr_mas);
+	}
+
+store:
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
-- 
2.45.2


