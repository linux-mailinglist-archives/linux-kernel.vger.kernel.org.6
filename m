Return-Path: <linux-kernel+bounces-310997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2465E9683BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559801C226AC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02AA1D27BC;
	Mon,  2 Sep 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WCcFojwo"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011045.outbound.protection.outlook.com [52.101.129.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50644C76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270754; cv=fail; b=nNioUhT67lQmv3oY+AgEUax3O0EfEnjDMYsdSy+4ld32MVD3Jk2lFQ9J7LVi+LrU8abaO9K/cEb83cOEjSthTI8L0e2k+7XN6GlU3SFUbGonSa+m+BGO9z6FnmwUIQYVmPfpjvcwrLMc00EIvj6a2RkQ/BINAJamt0Uyd+bTfpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270754; c=relaxed/simple;
	bh=Pqmg9SrwVAkIjRLLkgqmCXykc7zEck3cE99q+WIjnQ0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzQ4Hq8rPecaDXB0crbrCQRUcn28ysjpIcob8WAHtZBQAUdrsTDPIoubsjJjHA2ICBiYBXgdvCsKiRE9ox+aqRvgAdHml7xx115RRVMoIG0wWwo04NZ+XsKJJX0LjZI+Cx0YljLjkXRVw7yyOOiOiOebX4A/Emz0GS8KPqmV87A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WCcFojwo; arc=fail smtp.client-ip=52.101.129.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rIf+reYVmO5Nhkd2SWco1fKOC7Jcl6ULCqq564kfCLud8BEm+whUeg75FhoyqkzLlG2DkY3ejnukaJdAGWIaCwFjDsfWViivyptN0KPDFzcWZC3QFB6cFSXoQsPQ3B3tiilqbGDhH/PDBtfiHUiBSd2ojwS2qoy1xaSgI0Smtec7B4LNJDXf15tA7q1mvThAYPe8tiR4eKHrihuPCxn7hPP2ItMtrxyhNZqL8igjJf0lRGSSu04ZkbSsPRAJ0WAGalSAxwAntV1w3V7W6z2NPJFOfTo5F2Vxl/aoO5W7WTsVDJObvqL38m0OzJniwwKXioD1NCHtqRjH3qok0ytzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVTjQNHCGZATCZHuSAZhZCspG3eszWFbAeloqXRSxIE=;
 b=c4LkoWOryTpwIsE6Uf2FmpoqQN4SFYuX2/AalKnrTbCTl6BRxXMnAlwmtXlBVWX/KJf22tU5owgFlGnukpB73tK/y5B53dKg5pKr8/jW7LREb5LurC5mq1neZuySvg1aklU+CS4hbMmdASB3dOVtfFbq4ProLXVTNi7auelodXxq0IgfFt034INlISdIcq6jZt8l7YH0lG4JtAfK8gBSHKqZfZvynfSDR8EBpJyRPfbHShAjErArwXDPCUSD7/n5sR+X8AEx4y+MT3M0jLK1jWxvAXRx3AeUDp2mk++0JpzVnpFSfgGSRL7D/Xa7J7F3Cudf/dMx15ZU18RlVgh3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVTjQNHCGZATCZHuSAZhZCspG3eszWFbAeloqXRSxIE=;
 b=WCcFojwoCCYd1XOWC85W1DwdmPsVjFrD/sC6cYTmsz7RLmm8NeWfYjnjk0lIJLQnYjG01l+Mj+DloD8uG+N5pNcpDCpvR6ho9pyZI3NOXSnm/uasb8UtR8SYma74xqezHlEgi2ekpxiAGuGixWVrYoVg2kpcSighce1T4Vpjnrqcfl6tlRtD+BzOLyGDATnpVAYluADOkqXF1V65avOudcV9vMBIw8MBnYXAJKEjiW74eASm+psXMY5WVjR1hHWePvzF5/tvufzgg0c5OPBgjEiM6t0ukGJSR++Yc/k4mFdazqB4i33QXKTGVxP0gcQKyZ9uAc8dCoupMWtOHCKozA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEYPR06MB6358.apcprd06.prod.outlook.com (2603:1096:101:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 09:52:27 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 09:52:27 +0000
Message-ID: <743d4b6b-c854-468f-a0c4-8adbf58cd0ea@vivo.com>
Date: Mon, 2 Sep 2024 17:52:23 +0800
User-Agent: Mozilla Thunderbird
From: Yuesong Li <liyuesong@vivo.com>
Subject: Re: [PATCH RFC] reset: Provide new devm_reset helpers for get and
 deassert reset control
To: p.zabel@pengutronix.de
Cc: linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240830033351.233263-1-liyuesong@vivo.com>
In-Reply-To: <20240830033351.233263-1-liyuesong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEYPR06MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 42da8cd6-f802-4411-0954-08dccb34f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0xvdk10MFk5MXdXWWZLZG5Jc2xybjY5S2w3TmNOUnBmTlY0eXAwMmc5a05W?=
 =?utf-8?B?dlVWZ3FmVi9kbXNZbzJrS2RROExPSFFRZ25HeWlvVUx2bG5hdWtiRytZc0E2?=
 =?utf-8?B?alJTajZqc3hkckJRK2xJa24xWWNMRnJGQkZrbHc0T1dSaFh4elpEbDN1K3pY?=
 =?utf-8?B?QnJrMHBhUU9pcjRwYUVaS2VMcHE5L0ViSFdTZTRnNy9aSitwNkNYWFZGVG9l?=
 =?utf-8?B?cVp4NWlDYkVwSE5zdXRXMEFINXQyK0tQTUU0N1lUU1dETENRcWxCVkZMQ3Js?=
 =?utf-8?B?ZUVPZm1YUFFSUG4xOThvaWFGMGltV1Iya05qR0J3NHFNK2VnbWNUYXNvMmxl?=
 =?utf-8?B?bkdHYVU3M3E5dFlnbGZrcjQzOEdJaGpmMFI3dFdMQjlSK0VKaEd5bXl3WEYx?=
 =?utf-8?B?Y1dOeXp2RFc2aStaL3BlRHZmQXVsWFpnM0xsbkY2OVB0aU54VVQ2VG92ZTJt?=
 =?utf-8?B?N3FvWXoxRlZsazQvVHJYT2xzdzR3L1Z3NTMrV2I0YlpKZUFXUlM4WEdFSkxR?=
 =?utf-8?B?RXVuQ1I2RkJWaHRCdk9PMUtBSVViM3doZ0NkemYzazdLVlFyNzBMcGtsTjNi?=
 =?utf-8?B?aEV0dDgwN01vTjJMOUlmY252M1l2RzNXU3RIRVloYzBNK3JRQmdpZnUzZDFw?=
 =?utf-8?B?THBIOFZPM2YwZnhCYmxtVUE3K0Nzd3Ewd3RacUtzc1EwR2RuWDZDZkhSbzdM?=
 =?utf-8?B?eUJ5WTIyV1dkaHZKTEZxWVJ0amVDQkU2Mjc2S2VBOUcrNEtpMU5TZjl6YnZh?=
 =?utf-8?B?NjJJNnAzUkZxZWNKWmxBaEVQTjduMzdpQVpnekZCM1g1NzZ2NmJVSlNzWUVq?=
 =?utf-8?B?NURYRnFSa1FpSVVQZFNxYTA5Z2hvZnFib1E5OCtYZVpLWlVYV0owTHZGZnlG?=
 =?utf-8?B?K0NJSUlyOS9Ta2dxN210Kzk5RXZ0SG9FTExjZENwWk9WWStROGw4VlU3Mml3?=
 =?utf-8?B?eXlvRWdmQytMQk5LcU9ZNDRULy9CcC9mSzdMWmlMR0h3STYydzl6TTZoZlVP?=
 =?utf-8?B?S1YxRyswUTJyWG1ENENRd0tScm5CNnhnOEpiZUM4WDJJK2VEMlRFQWU5dUw0?=
 =?utf-8?B?b2NRQmJpSWxnMzhiWXU5OVk2K2dCaUZWUXRQV1dSdXh3NnAwaHhKdEZvNE1G?=
 =?utf-8?B?cHM2KzR5ckhJZU45emFlTXM1YW1CaHFyTmo4aTlWdk1FU1Bpbm55b3orM2do?=
 =?utf-8?B?MzNYV2NsYXgvZTM5M2VoeHFlNm55V3l6QlowcTR0SFM1Q1IvZFVnNlR5TlFr?=
 =?utf-8?B?aGhnOW9aWGVzMENINUI3Tk9NNEROa3VLTTQ5Mjk1S0RDOTdFSlFEQnJQY29j?=
 =?utf-8?B?WitjdEZ2dUx4ZU1rNGV5Uk1uQ284eHI1WmpGaitwOUVDbFlsQmRvTWVBN2R0?=
 =?utf-8?B?alg5UXNOSzlnM2RzOGhrRVF5YTFDb216K1pzdTlPY2d6U1F3NWhaMkpURDhk?=
 =?utf-8?B?WjJpL2RTSXlCWTl4RjZ6dTM5R0JZb2tHZUMxK0pkRGlaTmx6Unl5TWRndHIw?=
 =?utf-8?B?aGJGVGxHV3Mvd1RhTHV5dUp5eW9uU3JLS2NjNkFaQk55eFhCdXNmQ2hYU2RH?=
 =?utf-8?B?a2U5QTJ4ZjUxQUdJZWYwckZRQTVobjVUSWZjNkYwR0FBcnlrUVgwZkpwU0Yv?=
 =?utf-8?B?ZDRISThhZ1dFU0FUK2dJRmxDSm14cmdKeUk5UDV1OUtCRFY0YXRsT3I3dGZp?=
 =?utf-8?B?WnpFVll6dWM4cVRvR2lsR3lDTVpDNytlRjZ3bEF1RmtJcUcvVDJNaEc1WFlY?=
 =?utf-8?B?ajkxRzB1QXBndVVicko5dG1pWldXK0Y5VmROY2daVDVPZkRaK3hUM3JXY2tX?=
 =?utf-8?B?YWVyT3hURlpWRG1JRlg4eFBtTlQ4Sm9hOXh0cDc0NEgwT3FTTmdXeUEzS2tO?=
 =?utf-8?B?WThndEtjRmczVVZkZmNWeWJvcUc0WmQrZHd4eXFQTSs3N2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3UrV0VzSEM2TWdxZ3plUVhocWVLTEtJWDRGTkFjUnUxYnFFdkNrWXZGUGhK?=
 =?utf-8?B?L0czWkFsemtRRmZ0QVBCSWpLRDlZNGw3bTdQWGoxcmtLYXA4cGpEaFp3NGlS?=
 =?utf-8?B?Zmx0NFM5L0RrUkpIbjI4K0Rqdk1jcTNzeHExWDVNRlp1azRMRDM3SDg0ZjVQ?=
 =?utf-8?B?RHFwWVN5dS9QcmhUL3dBdGdwc3RLWVBqSmN4WjM2cUtUMTZHVVpNUVhSZEJR?=
 =?utf-8?B?VFJuUVBCSGZhV1VnemFVakFUL2JZVzdaVlVWTWg3cWQyOHhyTnFvaXpGNm5p?=
 =?utf-8?B?VG9ZZWJyRjRuZDV5T1ZEL1dLbFU2Unl2RWVaSnFOYXZrUUxZWkRGRjlveUll?=
 =?utf-8?B?ekNUQ2hTN0tpM0FkUXErTnBzeXY1TStkbDg4ck5nZnNsK3lXNmJSVFBnby83?=
 =?utf-8?B?L244QVd2NzFJK05yekJXdmk4UE5tY0dSTXgyM2E1NUUrc1lwTkhSakFzbDBN?=
 =?utf-8?B?Mk56T3ZLWU43YjlEbVM2b2ZVWkZQK1NNYlZWTVFkZWlrK25qTE9LT1hRWG12?=
 =?utf-8?B?enpJUXNBRlVyenpFYTZNNjZZTjcrdEZQaVB2dXdkM0lzaHdXSkN5bC9RMmtk?=
 =?utf-8?B?WlpveXVoYUpTSHRhdmlDcFlkdzhKSFZSdm1qQkVjMjlENnFFczBkaGkxQnAy?=
 =?utf-8?B?cW9iSFRDSlFhT1JPenNSRkUzY21zaVlqVy9RTHU3NkNMdi9PK3lVUWV2OTdn?=
 =?utf-8?B?c2dxZFlTSTBpTUtQOHdmL2ZLTGhyYzJhd2tIZk1VSGdRWHBNUVVMek83MUg0?=
 =?utf-8?B?eWZJM1lmUTZaLzhsempaODhkY1dCQ1BUVUZKU3JHUllWUUdzMVhWcUR1WnMr?=
 =?utf-8?B?YmVJR3dtNHZHMlJnT2h2QlJNZ2V6UGR1YlYzUlJjakdrcUNYelMvZitEQnRV?=
 =?utf-8?B?b1BBMmJ2OFdpSnc0RndESW1NOUUzcVk1eGhlei9hWUFWaHphWXMxWkg0SG1y?=
 =?utf-8?B?ZzFiUGJaZnR5WENHUlpLTHEyZStqSzh5RlZYNEtEdTVsVnhSTU9samhGb2NR?=
 =?utf-8?B?ME96K2hJOFJNb2ZmWlM2cndmYjlCaGNmV2FiR28zVC9TWVBmRENId3A5akFn?=
 =?utf-8?B?TFFobzdNMElTdFFIT0VnWUhnVGdVMjZCYjVuai9ZWEZpUTdoN0ZFM3V3ZjFk?=
 =?utf-8?B?QTlJOC9CRWRhVU05eEJGOGZjZ3VjcE5FOG5hUDBlU292eFNpL0g0bFcwUHBm?=
 =?utf-8?B?cU56eEc3Uk94NitxUjNpbUt3SjlqeXlyQSsvM3VXWkwxdDFIc1hqK3dSaW5O?=
 =?utf-8?B?RVNEamVKbklwSW85YUNCLzc3UE5GbVlmcmtoWGgxeHMya25tVEdaOFpmcElP?=
 =?utf-8?B?YjloUXBXQlErZkpRa2JpNW5QMmRXSVhlUTFXMG4wQ2c4QVVkTjZRMkJNd1hw?=
 =?utf-8?B?T0FGTjFxb2xpM1R0RFcvSnl1OWx1L1hGdEtXQ0RpQ29ueXBhZkg4R29SSjR1?=
 =?utf-8?B?VFZpYnVUQ09lZVFBeS9nRmxxWEVJeDlhU3RFcTJ2Qk1UWG1tLzQvbmwzcVlK?=
 =?utf-8?B?ZFlwMlFwTmpjTW5ROGhhdkpVVE9vRVlaajhZSVVaK2xwVnZySHNBdXNVbERa?=
 =?utf-8?B?eXV1VitzUXVEcWpXbHEydjRuOWZqdXB4Q1haWHJ2Mm5mVGFuVDZIN3EvWUc5?=
 =?utf-8?B?eFRBUHBLVGpWWFBYc3VIZ0MwMm96NE1BUlVDcytTdjNodlhTd3hvOFdDbFJy?=
 =?utf-8?B?NDBZVUNHdEZHbmt2dU9MSzlvWVdsL0dyUHpkc0xFVUQ5Nlc4RVU3Qlp3VHFy?=
 =?utf-8?B?UGpLWDRkazlCRnVKbXlXVXJaRFVGV056eWswa0tJQWN2ZjlvUjFzWGlLY0hv?=
 =?utf-8?B?OXlxUlV1dXRLK2xEQTNtZ043RlpwUG5Wc0taQUdsbnhZN3NVWU1YdHBrdUM2?=
 =?utf-8?B?QTdVVDFhRWdVbTZXdDkzQktmMUhHMENzajJOdXhyZXRBRjN0MCtpc0hnZ2Zt?=
 =?utf-8?B?WXJLU2VudTlSUk1JM1pHRGFyVXFGTlNLRGVuY2UyWmVNdk9wTGtaOFBENit6?=
 =?utf-8?B?ZE9STjhXUTNWUU5IOG9EbWI4MkU3WWw1Wi9WbjZXRTBmZ0c2L2MwdHZ2K1hK?=
 =?utf-8?B?ZjRPbS8ranVxalRHYUgremhLejhqNWtNNG54N3dBWnMyMDhIcUg0UVhidXMy?=
 =?utf-8?Q?rJwcGzF/G9AbCmO92AU1F9glH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42da8cd6-f802-4411-0954-08dccb34f3f2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 09:52:27.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2mYGbKWDXemSffTS4rClzHwH7/ZcjlfMCEOb/+YomGTdYYZbvClJHPIEn1U+l5hUy6bInNkeiWPNL368TzPkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6358



On 2024/8/30 11:33, Yuesong Li wrote:
> When a driver wants to get reset control and deassert it,this
> helper will handle the return value of these function, also it
> will register a devres so that when the device been detached, the
> reset control will be assert.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> ---
>   include/linux/reset.h | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/include/linux/reset.h b/include/linux/reset.h
> index 514ddf003efc..d7e02968b63b 100644
> --- a/include/linux/reset.h
> +++ b/include/linux/reset.h
> @@ -806,6 +806,35 @@ devm_reset_control_get_shared_by_index(struct device *dev, int index)
>   	return __devm_reset_control_get(dev, NULL, index, true, false, false);
>   }
>   
> +/**
> + * devm_reset_control_get_deassert - resource managed
> + * @dev: device to be reset by the controller
> + * @index: index of the reset controller
> + *
> + * A helper function to automatically handle return value of
> + * devm_reset_control_get_exclusive() and reset_control_deassert().
> + */
> +static struct reset_control *devm_reset_control_get_deassert(
> +			  struct device *dev, const char *id)
> +{
> +	int ret;
> +	struct reset_control *reset;
> +
> +	reset = devm_reset_control_get_exclusive(dev, id);
> +	if (IS_ERR(reset))
> +		return reset;
> +
> +	ret = reset_control_deassert(reset);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_add_action_or_reset(dev, (void *)reset_control_assert, (void *)reset);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return reset;
> +}
> +
>   /*
>    * TEMPORARY calls to use during transition:
>    *

Please ignore this patch, I did not use clang to check the compile 
process. This patch is meant to simplify a common pattern appears in 
more than 10 files. For example in
"drivers/thermal/sun8i_thermal.c" line 393-401
But to pass the complier test, we need to include other header which 
does not make sense. So drop this patch.

