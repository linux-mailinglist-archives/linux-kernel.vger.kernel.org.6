Return-Path: <linux-kernel+bounces-214335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9940A9082DD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13527282FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 04:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC71146A8E;
	Fri, 14 Jun 2024 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="XpLg/YLK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071.outbound.protection.outlook.com [40.107.255.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7714534B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338192; cv=fail; b=dWGzKnukoZSTsbJxTEW1A80bI/4tmmK7KAgObzWLFBmcIibqCCfxD6tk7i17lr+2RWCQ7TyQlFOTtC0l3tKpapN71UyizBZ0q+AlyF1ePWb/gTcoxr6TahZyZ4WqN6H6JoBp52BtZghCTz4R6xxha6N3Zwc4oIA4u9t16+zBcM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338192; c=relaxed/simple;
	bh=7vbP6UfbLZmne061ZXwoNDhwj64ugLbj2NdDTu246o4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j6wBJAdPzbulBdV5Wk+T8m3c8AC57b0xOzqcBxwZOtqIpXz0w/I4HOxTQeMtdu9mI0OXBguMUL/xekTfekZL5w1NwymwSTea+HkER6a8Wb5O8KzCjFyGzMsCeT9OgjvuHv+zFyC7Ay2Ex20FPxhIGiP4vGZngOmjusaUy775H6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=XpLg/YLK; arc=fail smtp.client-ip=40.107.255.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnTA2ws0ctvdYo7pKH+bOfcw34hwmAV0kJ6mGNgD69Ott7TZ86RrTV22ZX/yPcWXEc/7Pug0etazxJW4m3q038EBeWmBhmI2m2B8L6XQGAJKJoLwryLeVhD7V0BkFsaenepv4tkoCFX3O7f4wDF9L3ZC1Y4e/dJnM/WUf9MiTgH+99UK2m747shot8e3Wdz3EBt+lnVTIfL5ralvk/++Rq7l6HmXgTbsnlcAUK1iEd4MIC4+2IdOFf7G8zR9KDD9+0qN0fsnZzAjywFKN3IOcBl93O6zmmFYGRBQrS8nqoT285/nJ/jNAi5Kusn7zl1t0889alrcxZLx9h4RW5Jf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fiFUQjwec4O/rw13qF2DxezCQmh4h1UV0LsxXRvKF4=;
 b=gk8uBE4CuEPP3RMUOZ8iwio9aE3Br+DQZXkBRJme4EO8f6lDENTHZDOJWFwpSp4XXReqeK7Stykbz2iRcLW8KTNBotKk8vEff24qDLQd10AL7qlBUam2r4HB/R2xxwIIYsrKgcBFMukjgEgg/v4jaj8MMqx+PBfbjkX4PRO7pLUuohk5GtvHAVI5L4/M6A6v2qH5r1xTv13h0sRLb+iSx1Tez0mMt6rTqBJkYwLhiIOq/KatYtEqeSJREGfZGrG2GmK7dBi5emurbOq+AD5dJ9zCHB3gE7vPw4QVYZyYkeX/OaOYz0lqnwVwyKte/nY/K5Otu2BRXNklNCIE1578Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fiFUQjwec4O/rw13qF2DxezCQmh4h1UV0LsxXRvKF4=;
 b=XpLg/YLKVf2AcsX3NToCcC+ZBKXNNvXIdTSATcTdpcb3lW3sg7hTo0coy5uchlWSP84tAa4NII3AXwtzDkt3MqYgr+OzgCxvDsNHKNz75u7CVEU505o2rwBxC0484OnkqW3ETouTYTlcdvVg0hNMVFN12IV2fYVzf0LEBoxivhrC+L+RrHLhwebhPLQC5jaRHzrb+OlMwGB5cNhtsH/fByy8zf33PWwtFjUFQcV+pbdrlp7/UuQQ7BUmqvqDDJ/Gdrn+uoPlv0O6svnD7CgtNmez6T/svcMLeVKS08s2PBoteIrhh9x9B2+7mvVECECZ6VS53MbG3x9BUzYqfvJHBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB6101.apcprd06.prod.outlook.com (2603:1096:301:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 04:09:41 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 04:09:41 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues
Date: Fri, 14 Jun 2024 12:09:29 +0800
Message-Id: <20240614040930.11119-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0033.jpnprd01.prod.outlook.com
 (2603:1096:404:28::21) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: db43acd8-f999-454a-2139-08dc8c27d08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|366011|376009|1800799019|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2ZDZ2F0ZnBEMEZDZCtpbmhIVzQyZTllYi9Lbmhpb3pzT2RPeFViYWtsdk1k?=
 =?utf-8?B?T0xqUTVsT0hURStKSUJ1bjR4cVppTi9pM3lSRyt1Rm1kcXh4Zk5Bd3NTeHB3?=
 =?utf-8?B?OEFkMVltU2NYZXhzVElydkVkdmFsSUZuZTgrTG9DbW04ODFlbEtVUXJkeTgw?=
 =?utf-8?B?d25PbHB2U1dSeUptTzkvaCtvWEVUcmE2U0NlRmJrWG00eis0TmxxS2p2c2xV?=
 =?utf-8?B?Unc4ZjNReUE1YVMyNG9jaU1sU1FaRjZ6M1B0dC9OVEg1NFM3R1RQK1A2dXNi?=
 =?utf-8?B?Kzh0cENUYTZVQzZQR2lNSFZTVzlrc2ZQREp1OWY3akROcnowc3BVVXYwWWZ3?=
 =?utf-8?B?WWdvMGhjbzFjZVRzYk4vQ2dFa21JNTNPbkQwdDduWXNtNDZ1NVBoZ1dacVhn?=
 =?utf-8?B?YkhZYjhRNnR1MHhPcHJDRVAvNlB3K1E4b0RyVCtKczAxVUlmSEhKRHRSdXha?=
 =?utf-8?B?Q1RnMm1Xck9XMFpkMSt5VmsyaytuTm5QekVEdkpYdzAvcXJYVmlTdGRQcFRv?=
 =?utf-8?B?NE9DQXZTYzQrMHBnbUFNR0lKYmNhUjB0L3lMSWh6WldiT3ZLSC94b0RvUVVz?=
 =?utf-8?B?bDBtdzBvNWFTRTV6cUM4QkFlYzFEK1hZR2ZXc1VDdkkycHIzTFVubzVYclkv?=
 =?utf-8?B?eWdPMENVeXF4NWlMYytJRnM5RUZPMlNhajhPb2lFdWhodlE0ZlNFWHVvOHc3?=
 =?utf-8?B?QllRd1VKeGU1VyswS3VmUzRQZUhPdXI4NkRBdzRlR2RJNnJGbzlaRFJGakxX?=
 =?utf-8?B?UEw1QUFLTHFXZ01jYmFwc3hrK0dwL0NLY1JWckp4ck9jR0NTcVhSMFFqaENT?=
 =?utf-8?B?eVJQYjFNZ1lXUUVSMUFSay8xeFhFVWdWL2NuWTNQZ1AxWWEvZ09YYXBCV3pC?=
 =?utf-8?B?WGVxVFpYRzBCQ1lSUlRTdStockFQQzdaY0RJSzR4bnF0dU9HbTVkeXJvWS9j?=
 =?utf-8?B?QUw3TEV3RzF0Vi9WZ001OFdUZStGanQvNGpLcnY5VVQvdTBNYkpNWnBzejRU?=
 =?utf-8?B?YnJvVHV6ei8vci83bGxKdE5HdmhFVTJyU2M5Ry9TUHpNckJuYUFKbG5odU84?=
 =?utf-8?B?UWNRSitSR0Q1T2YxSDhFSkw5OThuM09ESFduZU5zbW8rODRhcHUwbjA4MjhY?=
 =?utf-8?B?bTJ6WHRla3lNVThQNW5KampsQ3FZSWtkbDhsd3VWcXhXVTlTV0xlSzhlUHNO?=
 =?utf-8?B?eEl6N3R2NFVWaFYwRFlYcFRkN3NSWXF5MjBLNFZCTVBWSzRNSDZGakRyOGlU?=
 =?utf-8?B?MG92WjNIUG0zeklxb0hSekx2QjFvclcyT0hWTDlnRURZRDlrSWJzTXBqcVVw?=
 =?utf-8?B?Wm1Qa082UDhHSU9ZcU41elBWdzIzam1CQUI0RC90Um1RQ0VJcGQxdUpSSDJr?=
 =?utf-8?B?NkVRNkZVZi9ISWNSMVBjUUgra2N5bDZnbFJZVmhiRkZIelRsRDgvQ3c4aW1U?=
 =?utf-8?B?TllQYkl1NTh3dDFib0xmaktWbUNuVDlGQjRoenNSK0pEOHcxd0padmgzWXFD?=
 =?utf-8?B?dUhEVXk4Y1lMK2pCL25nQU00dzJ1cDJMNGVDckRTbzFMbHN6eVl2YlR1LzRs?=
 =?utf-8?B?Y2pJdS9yZkNyUnFGeE80dnhjTjdOaVFkMXpaRmJDR1VwenA0OGtGbU1tbTFD?=
 =?utf-8?B?Q3Jwdy9DLzIxZVI2L2NiY2xWWVlNKy9qT3pYTkZtM0RFczRUb1J1elJqaUh2?=
 =?utf-8?B?SDIvS1F1RFo3TTFnME9EN3ZnWDFLV0F3NWVKY1lMK3p5OVlqRjRqL1BWeWZ5?=
 =?utf-8?B?SUFGTWV1bHlOR1ZQNElhZGJsdnlVOWxGQ05zOWxEMmZCWHlWUGlQTU5rd3ZT?=
 =?utf-8?Q?7tJ1iCLhsVvkHtj0t/gMP/SikBptAM7T0p9wg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(366011)(376009)(1800799019)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGFXWkxmV0kvV09ZQzN4bXdiUnE3U0s5Wkc1RnZBamtHeWE1a1d4S0pWUGF4?=
 =?utf-8?B?cDA1MTNUTUhzL3pMb2IyaW05MnJ5Vy9rRVFxWHNReFBhaEV1RUZ5K0N1VzJu?=
 =?utf-8?B?MFNuTFZTYVl4SjJ3ZHhEY1hyN1FTRXpZb1oxSmZJV240OWU2OEwrVFhWZy9J?=
 =?utf-8?B?L3R5czdta1NQL0ZxN0NjajNFREpKWHpxWUJMRFRBbGtzQ1J3Y3NXb3BpbmdM?=
 =?utf-8?B?bE41SWp6VGlnTUZZekRNK1V6WktzbEVNZ1FIRm1yOC9nRmJSUFQwcHFEUGZH?=
 =?utf-8?B?cXNZVFpIWHVSdDFoTnhuMjhmNzF1dGxSUWRhN0pic2p6ZTNMUHd2MFVjVDY0?=
 =?utf-8?B?cDBTb1QxY2JpUmpTR3RSaWRtS3VTUy9WSnNFbElNRlBET1U5cWJrTlZ1NFF2?=
 =?utf-8?B?b3htUTNyYklUWmJQVEdKYXFHWDc0UFdaV25SaHdsYWJHY0VuTEQ3Y3JOWjgy?=
 =?utf-8?B?dDRwWno2clYvdjVoY094Umk2Nzh0YTc4K1k2Vk9OUUlKcnpxSEloSzNNZ3FW?=
 =?utf-8?B?eTZlL0IrL0RhSDJBd21jdVk2eDJEd1NEUjhDTXdYNFBVMGNLYmxYc0RkcVFI?=
 =?utf-8?B?TDgxcUpMWkh2TjZqT1o1S29MNUVqMEFENkdvRUd3RTFRUmFNTGhNN1p2Mjcw?=
 =?utf-8?B?eElrWWVrd3NVKy9hdi9OU0FYbHQxQ3VST3JSVExubnJhK2wzUS9OK2JtMEVV?=
 =?utf-8?B?cWxOeVkzemZVdGhKenV4bzNKditodGpZKytuci9VUXVIai9PejE5Z0ppdWJs?=
 =?utf-8?B?TkxuWFFPaXA3cWRWbmZ4bzQ0bXRSd1cxQ3ZtQlo4Q3lvMHdtQ3VRS2lmQ2Nx?=
 =?utf-8?B?K0tTQTIrL0k2cHl4WksyVG1wWlh1VWMxV1lKVmpscnBKcnExbW4rKzh2RExm?=
 =?utf-8?B?cklTbk53SzgxM2RiK2RYUFlzeWt0N3JWMXFHQmZ4TDYwdjVKZ1dDQWEvajFq?=
 =?utf-8?B?WHJpc0JTN0gyUXNLaEhKdHlWVFV2OC9oamJiUVRHcmNVdEFSbUNpK0laMWZC?=
 =?utf-8?B?T2FJUEtiUXhTSFFRMHhIcUZPM0RuVHRhS1FOa2JSVXVSd2x4bWdzcEw5YzNn?=
 =?utf-8?B?WjQyQlJubnVoV0psRHpHWDE3MVR6RzJxWGlRN1ZlVlZSUjBSRW9EdFBCVXVL?=
 =?utf-8?B?clIzeStKTkp1ZW5zQ0xmZ0dQc29GNi92N1RTSjJPSExKNFFOcHN3WmxqMmUx?=
 =?utf-8?B?dG9HU1ZMWmtLQWZIeW5XN0VvdTVlWjJ5S2paVkx5bTRralg1dThGV3UzclFS?=
 =?utf-8?B?eVpTQ05WWXU2R3UzMHNObzhCODFzYUNlUlR2em1VZjZPWUZ1R3RsaXdrVTFm?=
 =?utf-8?B?NzFNREM0REFLQmpiRjBpcVlwcms4SjdEa0JBUlMvdWswNGs3dEtSNlVUVDcy?=
 =?utf-8?B?alFiakJ1czd3UC8rRUs1eGwxblJ3MXM3UDJxNXZCYXpUT1FQRGEyejJhQUxx?=
 =?utf-8?B?NjVBcC9YRjJ6UVdzbUcwalpYSmlUMmd3b3hGc3lFVWRjakVuNHBodk5ESGFR?=
 =?utf-8?B?OVBWc1ZrRXZXbnIvK3V3ZjJnQ0RGT01Td1FnTUQ3Vmk4Q3U3Z2JOQnlTMVVm?=
 =?utf-8?B?T1g4ZTJRWWVsQ1FLWERCZlBIZGpEV1pNbjFCeFZ5SENhenhzT0FzYU1aOGN2?=
 =?utf-8?B?U0xCcVZUTEd0NkR0NXdvUnFZbUZMTkFHRFVIdTF2S2hqQW40bUtRUUJPM05L?=
 =?utf-8?B?N2E3NlBIQmM5RUlsZCt5bHdFd1h2N0UyOHFoOG5BaDRTZGFaUVpCcGlNK0cx?=
 =?utf-8?B?SlRCQmQ0dTd0UGozK2s2L09McExKaXdLbmkrYUZXSTlYUjBleUFSY1RTR0I0?=
 =?utf-8?B?d3Yrdnh4L0IvYWN0bTN6THJUYVZWZTVqdDIrV2x1VEcwc2thck1QYU9yZlRq?=
 =?utf-8?B?WWVCTlh5bjFXa21WclBmOUhRaWoyQmtTMWZIbVRyYU40aytJMmcrNTNmVWVS?=
 =?utf-8?B?Zk1mNG92MEl1QUhEb1R3bjhYQVpiYWxmWG04aFdmOTNqakkzVjA0blh3WE1r?=
 =?utf-8?B?c00reCtodnc2NFBzVUNmRGNkaVFtTUV4cFhCd0dNZDFCTHRmMGpHcHllT2hY?=
 =?utf-8?B?ZVphOWVVY1ljOXN5clNVMDArWVpleG5aZ1hTamlYeGt0RjkxYmVZQ1NvZnZx?=
 =?utf-8?Q?aa88oZqY6DztOc2Kyz71cRAZv?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db43acd8-f999-454a-2139-08dc8c27d08c
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 04:09:41.2702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd5t8veihqgD2M+npof168dynqEHoFhSFeb1wwYHwW9wF5gKQpE9L6UUaOveYtyMz++WLwJvqN62+3NAouz1Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6101

1.In binder_alloc, there is a frequent need for order3 memory
allocation, especially on small-memory mobile devices, which can lead
to OOM and cause foreground applications to be killed, resulting in
flashbacks.The kernel call stack after the issue occurred is as follows:
dumpsys invoked oom-killer:
gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3,
oom_score_adj=-950
CPU: 6 PID: 31329 Comm: dumpsys Tainted: G        WC O
5.10.168-android12-9-00003-gc873b6b86254-ab10823632 #1
Call trace:
 dump_backtrace.cfi_jt+0x0/0x8
 dump_stack_lvl+0xdc/0x138
 dump_header+0x5c/0x2ac
 oom_kill_process+0x124/0x304
 out_of_memory+0x25c/0x5e0
 __alloc_pages_slowpath+0x690/0xf6c
 __alloc_pages_nodemask+0x1f4/0x3dc
 kmalloc_order+0x54/0x338
 kmalloc_order_trace+0x34/0x1bc
 __kmalloc+0x5e8/0x9c0
 binder_alloc_mmap_handler+0x88/0x1f8
 binder_mmap+0x90/0x10c
 mmap_region+0x44c/0xc14
 do_mmap+0x518/0x680
 vm_mmap_pgoff+0x15c/0x378
 ksys_mmap_pgoff+0x80/0x108
 __arm64_sys_mmap+0x38/0x48
 el0_svc_common+0xd4/0x270
 el0_svc+0x28/0x98
 el0_sync_handler+0x8c/0xf0
 el0_sync+0x1b4/0x1c0
Mem-Info:
active_anon:47096 inactive_anon:57927 isolated_anon:100
active_file:43790 inactive_file:44434 isolated_file:0
unevictable:14693 dirty:171 writeback:0\x0a slab_reclaimable:21676
slab_unreclaimable:81771\x0a mapped:84485 shmem:4275 pagetables:33367
bounce:0\x0a free:3772 free_pcp:198 free_cma:11
Node 0 active_anon:188384kB inactive_anon:231708kB active_file:175160kB
inactive_file:177736kB unevictable:58772kB isolated(anon):400kB
isolated(file):0kB mapped:337940kB dirty:684kB writeback:0kB
shmem:17100kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
writeback_tmp:0kB kernel_stack:84960kB shadow_call_stack:21340kB
Normal free:15088kB min:8192kB low:42616kB high:46164kB
reserved_highatomic:4096KB active_anon:187644kB inactive_anon:231608kB
active_file:174552kB inactive_file:178012kB unevictable:58772kB
writepending:684kB present:3701440kB managed:3550144kB mlocked:58508kB
pagetables:133468kB bounce:0kB free_pcp:1048kB local_pcp:12kB
free_cma:44kB
Normal: 3313*4kB (UMEH) 165*8kB (UMEH) 35*16kB (H) 15*32kB (H) 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15612kB
108356 total pagecache pages

2.We use kvcalloc to allocate memory, which can reduce system OOM
occurrences, as well as decrease the time and probability of failure
for order3 memory allocations. Additionally, it can also improve the
throughput of binder (as verified by Google's binder_benchmark testing
tool).

3.We have conducted multiple tests on an 12GB memory phone, and the
performance of kvcalloc is better. Below is a partial excerpt of the
test data.
throughput = (size * Iterations)/Time
kvcalloc->kvmalloc:
Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑

kcalloc->kmalloc
Benchmark-kcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
Changelog:
v2->v3:
1.Modify the commit message description as the description for the V2
  version is unclear.
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e1f261ec5c8..5dcab4a5e341 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	alloc->buffer = vma->vm_start;
 
-	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
+	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
 	if (alloc->pages == NULL) {
@@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	return 0;
 
 err_alloc_buf_struct_failed:
-	kfree(alloc->pages);
+	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	alloc->buffer = 0;
@@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kfree(alloc->pages);
+		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
 	if (alloc->mm)
-- 
2.34.1


