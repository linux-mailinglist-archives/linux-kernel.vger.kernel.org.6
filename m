Return-Path: <linux-kernel+bounces-343563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0789989CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C091C21822
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F51741CB;
	Mon, 30 Sep 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j3m3pgHu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CT7va0VU"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F81684AE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684541; cv=fail; b=TDpE9Gb3NoScMaHj7nu38lX6O9ObKRinoEkfzkhO5aVtU2GEdH17X/PMc+tlI/XllhmpcASb3sCkNFy6p36kqJ/5XcwXrC2zSe3nPdLqd79CqcuARyg94MFJzMR4gzKkQoNcy6x4NsILbQgGmdRyyJjZrgpjVwfSPJ1oNXAtzoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684541; c=relaxed/simple;
	bh=b4lmiqPTolop3P6XNwBNgF28uqM+i7RF9n4UuoW2CSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UGqsPnye3i35TCN5mOk+CAyNUwRH7D8LI6TXyQHVVV3MO+LOoyXMR80OnzY9CPWhSd7HsclcMZrcs8426ZmkPlX8N4OLgp0cPTx8opx18YyvwoDmSJfLsh6vW31a/udURW6ELaYzm6sI6uqwZbpPjd6lOWRfmkknaHCcqwcgy/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j3m3pgHu; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CT7va0VU reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2txe1015690;
	Mon, 30 Sep 2024 08:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=KEH2Z58AkSnyu9R9k+SUgvnPjP8QZm7QnIwBHWplU/M=; b=
	j3m3pgHuodX/jOLJI+cFEuurIQT4LJW/S2rrrocL3dnhwaFAWLDHU6oX1XVLehLV
	/Ak4pTMvAVE5Tj228+2xcds9iwdlJ5L+al3i5JPqnya9qHZTZamApYrBrFshJMku
	znKdGfbpNwJe2YUg0oLv3K6aj10gPFvvKwHOayTfuAC24iTIPplwqwd7rH4f1eSg
	QeEZ2TjpGkeBI0AkSH66eeTp//lXlU960LQFbEYlnlSo7nJhx/NP3vcr7GV+fJLe
	ySHDNRd+1IwkiXneMQ90e7LnK7/WjhCfnY8Ux/Rq6hXwXAyIb7tQTKZqp83n4FN9
	vnTJ7X9LbNX73McBKUM3MA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1apey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:21:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7GqiT026192;
	Mon, 30 Sep 2024 08:21:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885r2nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBtp7nvwDPZec18MK4neiGe99TEAoaXDIEwo6YfD0OF67P4WQZ3zcelWU0pcgsysi1scIoDCXH2M0X0QFVqM9lThCI5Vwl2Fm8HIKGDjiHxPQuTA7Be2hpTWljwxRHqB2JTw26wPTfaKqzlIYju1fu9NWiT7r/j1iRPlfgteUs0DaZ61mVn/tR890iSc8OPGqnpChnaQVcqzFUS7AYrTRrfwFX3N2dftnyuMGO2fECeDbViGkLCegD9rJGgVce7W8HI3wLojnXecsfs2Szyz7v5ZCVvdLOOEYjXHcLjeeLBlqtlUKYuTi/uySihDOHQTh+NcpzPlTby5Az8HjM0t/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRwYY7vDiq12VqLpVyAzcApYiqp79ZgQFFLFArz7UAo=;
 b=WRht3ujMLascoBG0O7D2e5u+EtE9i9PjAprl4bBrTCoshkofWMfDGH4bO7xBjQ5SA1AP27eA/1KwaIduazOlnMNppuoBz7s6QbImoQ/+Z20pydDnV3LVHE9C8k3KeOnKndUtanWOrxQRAjnz0hZqG8MRS1OW00MTeE0V9Zu539T+En5Ezz6IsbBiyLRZPbSpFDFAN5nedYw72LvJYkZBxf//cth7DVPE7J5AG8tfXfLpARX5apH4T5gEmMvuj751JROZT2CJf5M/DpnF9Sx9TW+PiHd6krcyG4t87z3N1NwHLtH+VA6lyxnOrbcDXFgcfoLgib3nBpy8CLwgv8tTCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRwYY7vDiq12VqLpVyAzcApYiqp79ZgQFFLFArz7UAo=;
 b=CT7va0VUKaPmg1ByPMlvcvuKsSG3M+P/z0q4X25bn3cLs8IwKrpgKCRvB72qHtoli7k3m+99RFM0blV2x69Y8m6cJmYBpRoXZdmllTKczuAm89y1pdV9btr6+jtCiDnDO5MKydMEekhN1uKS5CNZPJ1KGvkDR/uRA6woagD3WD0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.13; Mon, 30 Sep
 2024 08:21:55 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 08:21:55 +0000
Date: Mon, 30 Sep 2024 09:21:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202409301043.629bea78-oliver.sang@intel.com>
X-ClientProxiedBy: LO4P123CA0624.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9c45be-f338-43ee-8c66-08dce128f1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?fEFWJLr9pM5+EvOQf29OW2svI+uf56fx0I1H7vH7+NNf4IOfrQrKG2l8sY?=
 =?iso-8859-1?Q?+OvVQhzEh8Ft1P01h7TB+R2UMW2OJ75/gFRKu2H4g8j51wNOoU+FDozf5q?=
 =?iso-8859-1?Q?hojb1hUWWPdmYFpkKs+Fu3LzskIUt+ivo4pKLr3iRoN2e+7OvloAktptgF?=
 =?iso-8859-1?Q?tHeeypIWVQTFQygMsgcYCwuxIqU4BD2LgYEyO5XdjziFMVxjcqWcrEIl0W?=
 =?iso-8859-1?Q?u8fiCa6VOUVPPBA8Mtcm6Y+ej/2BpBd0avZDBWuw1YN046mWO+3+Uvrn5E?=
 =?iso-8859-1?Q?kohTqjrXKpjbKf/1V7DW8PiORbQ3aT0Ggj+oNWIoc4HbLq/502OkFJz+3z?=
 =?iso-8859-1?Q?zcmXKivAt1dNLpWJgb6EonX6AEYi1A3pfb5ux+TKjaBbnIj2oyRJ1tUbuV?=
 =?iso-8859-1?Q?iVuUOASbJFLXQ8oENrVXUUI82dOPaamTPTuRyz8dN1z8skOWiRUf0fEdFL?=
 =?iso-8859-1?Q?fIHLHVYK8D7dUnv05qZihYewvvazDjmDaKXVXeihwusnCMLFSISljtf1Cp?=
 =?iso-8859-1?Q?UYMj3bHmkydotsCM3yC1jt2kdwNEcGl5BvKbKbgcPaHQIgMxAJeb+P2AiF?=
 =?iso-8859-1?Q?XF4hs91h7JaY9alI7T8cP9HVouHwtViyNk7UEPcNVJwd3/GmYizi4nI6TF?=
 =?iso-8859-1?Q?jZOzsOboqydVfsH2j+BTMJAIarQcYPz/ACvwiDVkVH1DtV4ufAAs5h8o1C?=
 =?iso-8859-1?Q?OKsfL5in6WFRS61NzkQrpAgpGKoZnbvB3JB4V4iOrbbekuZsiAOp1ButlF?=
 =?iso-8859-1?Q?4VpxkHPZKVluAKALexGvbNt0OX+fZEknNtiBgj7+qkDB/4sNT4Buym4gQD?=
 =?iso-8859-1?Q?7OlCeJ4zYYCRPv+ZmDQhcMuv1YL4Y2vIJEWBQbQ+R6bomI9iT7euL+Qfvx?=
 =?iso-8859-1?Q?OiclTWwLRAA9g3wOM7xJ6S6epFNn3zgnMfJo4evNhruDWgLgoaAuVWJh2w?=
 =?iso-8859-1?Q?usOi3fVP1uodt7qSWiF2C5rnf/G5QFbc2mbB7XTidl8YPm2SwadLr/G6s2?=
 =?iso-8859-1?Q?EAoHLWDQow/YmoW1tMmvoWv1ttKD4EsbiiEdg2hC8N5WZJfkk3363N3Xe0?=
 =?iso-8859-1?Q?jSUQlg+9NHE43BcBTR1w71PA+Rhw0gcmzb1q7DCHfGTa8/bP0ifeOFmWP3?=
 =?iso-8859-1?Q?j2uMIASBBx8DywS+JrD17FmHA6PtrMBS0QmSfBou3ThOr/OQ4DrhaFd4R2?=
 =?iso-8859-1?Q?o0SxCRnxLmoapFkBjnHRvk2L5JSfTiL+GyiaU1nKt9ivS5idTD61V/DKj+?=
 =?iso-8859-1?Q?Wms5cMvUwjYBtBDjaUc6UTejsJWKVVNdZEmBp1opEDsbr0Omtmgk2Ho8o4?=
 =?iso-8859-1?Q?AGu0A0O1gPOq70MeLA9RLJJrLXw8JS2vbk0YKQ1eQaG7OLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?F1y1Z5xg3A5epFj9uqMZmEH0zy5g6lm4F3M1NIK/P8yQP8eQ9SqPqfHOjB?=
 =?iso-8859-1?Q?XokCoDw0hLx4hRcSuWEkZ+vI0FZ2Bb0YTNJei5hGI9DnlDvfAru9XpPPKl?=
 =?iso-8859-1?Q?p+GSExORnZtgsgI/c0QUX0UQRvHaeFXfg6U2Xp0A7yA5Lkr98oTUYGj/Ur?=
 =?iso-8859-1?Q?J3R87wZTaeAXhm2N/QhkWZ9Ab061SqC0eCerdIvAV9C58smIIvbqjtIOaf?=
 =?iso-8859-1?Q?p6r8dJncFw6c2hj7Yl+waXlaLmzWJHqb9QL92s27zxVs/fDl1ElqTZCC67?=
 =?iso-8859-1?Q?pGnAe5jcDSUUVQw1ILyODcky5h1pTTp/h+vADJxMYYoPuRnLV9qKCaw0mk?=
 =?iso-8859-1?Q?sKZoaxIgIyCfAFZnqjodQCz19ZHZr0ITb9s3nr/1y3Bq9cA1w5+8QTJ6nW?=
 =?iso-8859-1?Q?Oqqw9Xg2CoTLL4kX8yI5VmoM/w4axDfPTm2wJo5IYIM5nks1jL4tKb4+cV?=
 =?iso-8859-1?Q?SEm13n3gKJBPQJe7MGW/s7ezMgRN38zjev1QAOz4aKVb+Gty7x3GJISYGT?=
 =?iso-8859-1?Q?ofoPAei6lyb2mP5J6FUD+fMRtll25SkA2+DkdyvBAPn8LvaxN/KVXwqH1G?=
 =?iso-8859-1?Q?7R4wDtGM7BRjqTV0Q9/DsQZZuCpr3QRLC1xdFZEJf1QlB8RI0q/h3gGgYU?=
 =?iso-8859-1?Q?TLc5d1CEHaC/Q+bosvgvyNw5vNAQU8s3yJ4Tg6ddPqv4QeAOUq0yMUaFwA?=
 =?iso-8859-1?Q?f/Qx116k8d82mjC+JXvhNEkV25kQJo2F0gDwWm6jOqZ7BBE9ZjPlzU/dry?=
 =?iso-8859-1?Q?YT2aMq+JKiqh/tdzLfF4rt3Quvq9YXNgnHyW2NfEJHzuKud5RX2NmPtHcV?=
 =?iso-8859-1?Q?TlGh7sLAlEDMNq8y3ktDRFgywmHVez9XjTfqeylcaELrVeIzPXH2WsRX1I?=
 =?iso-8859-1?Q?3Ep/+EhS5wNoHjGodsLSasSqb7noUnGssQIxUcmfz/MlMIWtwq2lgW8CcU?=
 =?iso-8859-1?Q?IZESk7bQKt1rxbDdCE1lVqDn63+0izO804myjknVAMJXt1d3BxZnGuQYHW?=
 =?iso-8859-1?Q?75HAh0h6DaXTfR6LEqzNo0EcYxwA17rHM0XExM0bPrOwaaSfhW+gD0Q596?=
 =?iso-8859-1?Q?hUIv1YNgtnclsj6eeFJh1Ua1LNNQJRK3VLUw1YCbxkgVlLNrqiJm9holyc?=
 =?iso-8859-1?Q?RxDfKtprtPfpj6JdNfcCJpjy5fW6gj1EFWIyddKa85DktO9SGmwBOlm+Qe?=
 =?iso-8859-1?Q?j28itSgcf6OsLUPZLFdSL0rrdAzahztUgiw+YbbjtaSQb/IxGByyVC1mqM?=
 =?iso-8859-1?Q?Y7RAwlrsf0l/NJ16HXhBilUJd94B4hWK6brIB9HjEPkGIg4nnpTOleZwhU?=
 =?iso-8859-1?Q?m7i7vNAEFfze6DNcoEUq4+M3pkLf8ZT0Qn4cTlwEUSbQ6o/BL00FS5bgAW?=
 =?iso-8859-1?Q?r1ITVYDbJ9vsLa5SwP3Z/bFQZUNhf9/alg5i6yWqAXpsGILo/lnkRB4Ezw?=
 =?iso-8859-1?Q?/WMZAefMsCkZYMJtoZPOmxo6PfLsq0aFMLM2V4GB6F3NvjZg1veQeBBlqA?=
 =?iso-8859-1?Q?3/19ebvX1tyZjy4rGfpLpk+b6tYNhN2lh9zYegGvkLbm0dxWQ3/Ha6SGgs?=
 =?iso-8859-1?Q?xzWcas0orDyoL5BuU0zlAA1ws7JT5MnL2W1lMR4vzENBEUPxMlDtjia3Rq?=
 =?iso-8859-1?Q?Eucevc8onWbazaxT1s/f7EVRQ5L6HMzv6cWhZmbxyIlve/okOu+43hdA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	00prbTb007JXisDF/StEX4NwDXWJzBcy0LYdxml4paT1iJ4sxcj+0glFdboaVnJ1fWYfmTKtRVkdqMZ3KTrTSetHew8V7Dfv7J5iS5MgRiQ7D0IKhV+ULhlfWQcWcHC5Y5tdh4dw6h9kGH1NN+qcpw2vK7hZi1NImQzULSwglSQL8amG7OAntzr290u0MV6oXFvTJxqYW3eLNDzUO4Ns6BrZ8b65IipT0dgVYZfBY/Sv9arJrDX6CL4oNwrko8FgTXsMP1Vz/5XIJR7No86bHZOY3FwKklCRFnRrBncYE3BVtouxGDRPOBsywt4TPxZ0pceo7M2o6osxkPMeMbfNDU5pOXTrJF2yzYGelikhtnG/bOAvcIEoEqVG14IPOJELF1nB1zwtd11oqjaLpxkUjLn6FN98UckTUHza+WRs9TdFvXU8hpDKv9wjW7/cC2s/SF+6DJBtSCQbl3s5fdDMgRov7mzrk2eIiEzpojh3W9A8hr0XGNuTt9KS/YPZxaRInyY1Zucr7lThDOE4wPMJOPS3Zpm01E2OMaOTUilWCaveMPa24cgzispIpVJkfUQY8CclEAYKDIztx1TPGt1nIh6/VvjrBQr01fah3J1zcHs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9c45be-f338-43ee-8c66-08dce128f1f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:21:55.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukAx2Ysu47RYBmtASPf0wXxr3vvZrRlD5xHIobM82eZmjtHOTk4Al3dXKTG8JKkvn4C0RmX6gBpHgnGdp1jBNH0+8jnlR9LcL1uk9rTtl8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300059
X-Proofpoint-ORIG-GUID: XM1QAKukRV0xEC3wncShbcc_U8DLmcyj
X-Proofpoint-GUID: XM1QAKukRV0xEC3wncShbcc_U8DLmcyj

On Mon, Sep 30, 2024 at 10:21:27AM GMT, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed a -5.0% regression of aim9.brk_test.ops_per_sec on:
>
>
> commit: cacded5e42b9609b07b22d80c10f0076d439f7d1 ("mm: avoid using vma_merge() for new VMAs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> testcase: aim9
> test machine: 48 threads 2 sockets Intel(R) Xeon(R) CPU E5-2697 v2 @ 2.70GHz (Ivy Bridge-EP) with 64G memory

Hm, quite an old microarchitecture no?

Would it be possible to try this on a range of uarch's, especially more
recent noes, with some repeated runs to rule out statistical noise? Much
appreciated!

> parameters:
>
> 	testtime: 300s
> 	test: brk_test
> 	cpufreq_governor: performance
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202409301043.629bea78-oliver.sang@intel.com
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240930/202409301043.629bea78-oliver.sang@intel.com
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/rootfs/tbox_group/test/testcase/testtime:
>   gcc-12/performance/x86_64-rhel-8.3/debian-12-x86_64-20240206.cgz/lkp-ivb-2ep2/brk_test/aim9/300s
>
> commit:
>   fc21959f74 ("mm: abstract vma_expand() to use vma_merge_struct")
>   cacded5e42 ("mm: avoid using vma_merge() for new VMAs")

Yup this results in a different code path for brk(), but local testing
indicated no regression (a prior revision of the series had encountered
one, so I carefully assessed this, found the bug, and noted no clear
regression after this - but a lot of variance in the numbers).

>
> fc21959f74bc1138 cacded5e42b9609b07b22d80c10
> ---------------- ---------------------------
>          %stddev     %change         %stddev
>              \          |                \
>    1322908            -5.0%    1256536        aim9.brk_test.ops_per_sec

Unfortunate there's no stddev figure here, and 5% feels borderline on noise
- as above it'd be great to get some multiple runs going to rule out
noise. Thanks!

>     201.54            +2.9%     207.44        aim9.time.system_time
>      97.58            -6.0%      91.75        aim9.time.user_time
>       0.04 ± 82%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.10 ± 60%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.04 ± 82%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.10 ± 60%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_write.do_brk_flags.__do_sys_brk.do_syscall_64
>   8.33e+08            +3.9%  8.654e+08        perf-stat.i.branch-instructions
>       1.15            -0.1        1.09        perf-stat.i.branch-miss-rate%
>   12964626            -1.9%   12711922        perf-stat.i.branch-misses
>       1.11            -7.4%       1.03        perf-stat.i.cpi
>  3.943e+09            +6.0%   4.18e+09        perf-stat.i.instructions
>       0.91            +7.9%       0.98        perf-stat.i.ipc
>       0.29 ±  2%      -9.1%       0.27 ±  4%  perf-stat.overall.MPKI
>       1.56            -0.1        1.47        perf-stat.overall.branch-miss-rate%
>       1.08            -6.8%       1.01        perf-stat.overall.cpi
>       0.92            +7.2%       0.99        perf-stat.overall.ipc
>  8.303e+08            +3.9%  8.627e+08        perf-stat.ps.branch-instructions
>   12931205            -2.0%   12678170        perf-stat.ps.branch-misses
>   3.93e+09            +6.0%  4.167e+09        perf-stat.ps.instructions
>  1.184e+12            +6.1%  1.256e+12        perf-stat.total.instructions
>       7.16 ±  2%      -0.4        6.76 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSRETQ_unsafe_stack.brk
>       5.72 ±  2%      -0.4        5.35 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap_event.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64
>       6.13 ±  2%      -0.3        5.84 ±  3%  perf-profile.calltrace.cycles-pp.perf_event_mmap.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.83 ± 11%      -0.1        0.71 ±  5%  perf-profile.calltrace.cycles-pp.__vm_enough_memory.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.58 ±  5%  perf-profile.calltrace.cycles-pp.mas_leaf_max_gap.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range
>      16.73 ±  2%      +0.6       17.34        perf-profile.calltrace.cycles-pp.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.7        0.66 ±  6%  perf-profile.calltrace.cycles-pp.mas_wr_store_type.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags
>      24.21            +0.7       24.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>      23.33            +0.7       24.05 ±  2%  perf-profile.calltrace.cycles-pp.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe.brk
>       0.00            +0.8        0.82 ±  4%  perf-profile.calltrace.cycles-pp.vma_complete.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +0.9        0.87 ±  5%  perf-profile.calltrace.cycles-pp.mas_update_gap.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags
>       0.00            +1.1        1.07 ±  9%  perf-profile.calltrace.cycles-pp.vma_prepare.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +1.1        1.10 ±  6%  perf-profile.calltrace.cycles-pp.mas_preallocate.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +2.3        2.26 ±  5%  perf-profile.calltrace.cycles-pp.mas_store_prealloc.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk
>       0.00            +7.6        7.56 ±  3%  perf-profile.calltrace.cycles-pp.vma_expand.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64
>       0.00            +8.6        8.62 ±  4%  perf-profile.calltrace.cycles-pp.vma_merge_new_range.do_brk_flags.__do_sys_brk.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       7.74 ±  2%      -0.4        7.30 ±  4%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
>       5.81 ±  2%      -0.4        5.43 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap_event
>       6.18 ±  2%      -0.3        5.88 ±  3%  perf-profile.children.cycles-pp.perf_event_mmap
>       3.93            -0.2        3.73 ±  3%  perf-profile.children.cycles-pp.perf_iterate_sb
>       0.22 ± 29%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.may_expand_vm
>       0.96 ±  3%      -0.1        0.83 ±  4%  perf-profile.children.cycles-pp.vma_complete
>       0.61 ± 14%      -0.1        0.52 ±  7%  perf-profile.children.cycles-pp.percpu_counter_add_batch
>       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.children.cycles-pp.brk_test
>       0.08 ± 11%      +0.0        0.12 ± 14%  perf-profile.children.cycles-pp.mas_prev_setup
>       0.17 ± 12%      +0.1        0.27 ± 10%  perf-profile.children.cycles-pp.mas_wr_store_entry
>       0.00            +0.2        0.15 ± 11%  perf-profile.children.cycles-pp.mas_next_range
>       0.19 ±  8%      +0.2        0.38 ± 10%  perf-profile.children.cycles-pp.mas_next_slot
>       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.children.cycles-pp.mas_prev_slot
>      23.40            +0.7       24.12 ±  2%  perf-profile.children.cycles-pp.__do_sys_brk
>       0.00            +7.6        7.59 ±  3%  perf-profile.children.cycles-pp.vma_expand
>       0.00            +8.7        8.66 ±  4%  perf-profile.children.cycles-pp.vma_merge_new_range
>       1.61 ± 10%      -0.9        0.69 ±  8%  perf-profile.self.cycles-pp.do_brk_flags
>       7.64 ±  2%      -0.4        7.20 ±  4%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
>       0.22 ± 30%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.may_expand_vm
>       0.57 ± 15%      -0.1        0.46 ±  6%  perf-profile.self.cycles-pp.percpu_counter_add_batch
>       0.15 ±  7%      -0.1        0.08 ± 20%  perf-profile.self.cycles-pp.brk_test
>       0.20 ±  5%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp.anon_vma_interval_tree_insert
>       0.07 ± 18%      +0.0        0.10 ± 18%  perf-profile.self.cycles-pp.mas_prev_setup
>       0.00            +0.1        0.09 ± 12%  perf-profile.self.cycles-pp.mas_next_range
>       0.36 ±  8%      +0.1        0.45 ±  6%  perf-profile.self.cycles-pp.perf_event_mmap
>       0.15 ± 13%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.mas_wr_store_entry
>       0.17 ± 11%      +0.2        0.37 ± 11%  perf-profile.self.cycles-pp.mas_next_slot
>       0.34 ± 17%      +0.3        0.64 ±  6%  perf-profile.self.cycles-pp.mas_prev_slot
>       0.00            +0.3        0.33 ±  5%  perf-profile.self.cycles-pp.vma_merge_new_range
>       0.00            +0.8        0.81 ±  9%  perf-profile.self.cycles-pp.vma_expand
>
>
>
>
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

Overall, previously we special-cased brk() to avoid regression, but the
special-casing is horribly duplicative and bug-prone so, while we can
revert to doing that again, I'd really, really like to avoid it if we
possibly can :)

