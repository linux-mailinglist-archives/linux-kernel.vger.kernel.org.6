Return-Path: <linux-kernel+bounces-203949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02118FE239
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5DC1C22F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FD515E5B1;
	Thu,  6 Jun 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="AD4+u4YS"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55B15DBA0;
	Thu,  6 Jun 2024 09:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664655; cv=fail; b=PmgoMAfJGihAhkgUnvcoWAZ5s3A8kTXD0DGwanYFdmU5hc3xLlBQoZTjb+gb+elxNOq56dekrcFhqzTXqTOl2tFzrrW5V4YtQxY3anP1cLmVFQv+fEV1aYTjjBd6KlFMLm5BgQ4lZ3wTAqDc7hik+OdFlqIdvPYXN20Oa9mqK0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664655; c=relaxed/simple;
	bh=ID7YG32TeXSAXxZJNLninYZh2bWpM9/iyN1Cc4WXRxk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KqwVVK7P2/KyAXboP2K9oVP6Ol2q2QdIsXUDfAWs7CH0AY5xM8EH3WNYqsyHdllUzruw6SXWOUgbNe4TP1rMsk/CWsLLG/A2mLB2HSk81H6NXaMEoL8fag6pG4Y1a9lMC6y62SXp3YAsLcUuc3o/zGWbqaJMVzsYEwkcMr9dOCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=AD4+u4YS; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6ymenLIwI5nhxrNhBrUJaZJ8M89BhoTb/ha6clT/MjF5ewjQ4RxiFhZQR9LgN+YIXClrzDt87gWQCQjf5GgFUw5JkINnZQ2dcDssEaKvJJEJhreC7VV9ntXQGeRuXlBAKSFp/2xrFaJBB6ut9l9RtgKNQPxZNoE0TGj6/yrhcf4xzHVPuIxSK7oRonnzeZI4QQ9X1wT596dWVKUs5UKWvMqF44i5qBC9JXXxvr05LmaFhGxrt9uAHCFXSO7FoEPH2wjx4jhRMUNsLKDwVemOxTAzxXNR006J93Pw/k20427WaWfJ/AwEbh8gkuQbUV8Ah9s4AUiM8LPIC4/RYW3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVZ0JUFz3CVufc2+crB/U2g6Wz+sjwpyecsLlOCUacc=;
 b=LOUlPazOI6ZOhzNCTVToLugwNjuHb5w6J+0ZlhemF7u8PqmD+HwO331QA3nzTiBDmau1+InT/Mrm8JLsX5U+pQzOTftL6l7Nuchdu0tXlEf1q+VFgCnpDUntcOD42BI+9GwMWWNIeM155xidr90Ig1s8haG+Z3Ou2ko7wlDNh8fPjHeYaGPIihwnXmYte/ts8fwT6oQPYzX6fWXM2dyICfjZAsry8wD+83LX86B48qXgdXXnzk/kUWzIqHUgsFMSb3qDXf1a2TrzKXprLKPcKjG23mrP05ATkKVf3lWTS9qEu4JhpUFQNI4n2x7HLnj82sqyqkGpqdrqvEjq6SlnOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVZ0JUFz3CVufc2+crB/U2g6Wz+sjwpyecsLlOCUacc=;
 b=AD4+u4YSAr1anwAl3/Mj3BVgtiXEP83jF3VwSS5RRKsavXZPK7fowSKApcgyuc8ti6tMBBg0Yb13HVI6tHgDGDSGTtr60BMHd6qDWx5RuRwf5f4+w4RGI5TusUN9tN8IS4CZS6loVi7323S9oqcujQIartbm/gXMSI/QDOyrPjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB9513.eurprd08.prod.outlook.com (2603:10a6:10:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 09:04:03 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:04:03 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/3] usb: typec: tipd: minor improvements in the firmware
 update code
Date: Thu, 06 Jun 2024 11:03:54 +0200
Message-Id: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHp7YWYC/x3MTQqAIBBA4avErBNUKqqrRMiUYw1EifYH0d2Tl
 t/ivQciBaYIbfZAoJMjb2uCyjMYZ1wnEmyTQUtdyEqWYvexKpv6Nu4yh7e4k1m2SSirauUQBz0
 gpNgHcnz/465/3w/Af41KaAAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717664643; l=1261;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=ID7YG32TeXSAXxZJNLninYZh2bWpM9/iyN1Cc4WXRxk=;
 b=RXflbzd8qwBw9FTWCQ177u6b6qQM4DmLCDI1IjA0MDKs3ZzF34Pk7R1T0qrKT3jRrKBpnvJIu
 NCTyUqekVrFA6x4xa95Nk21jRSajVRFgNUfkk7cO3d6mt0Of9EK6qb3
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0310.eurprd07.prod.outlook.com
 (2603:10a6:800:130::38) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: 856275c7-dbbe-4023-b90c-08dc86079cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REM1MzZYWWp4RjNaT3ladDhPbXpZOFU5S2ZlWU1FRVVHRmxvYnlYanpLVXVa?=
 =?utf-8?B?ZXhJN3V3eVhieXZ4a0xGS05rWE43V1JqR21GSXJBZVNvbm5oa01oSmV3U3Np?=
 =?utf-8?B?TXVZYmZFMlU5b0hZOG5EYUtiNnBaY1JzWHpDNm1pSHpuK1h5MGFIRDVTeHNk?=
 =?utf-8?B?S1U3aGt4REFlZWNCNDlTVDNYVmwrZmhiWUVsTnFhQjhNMG5ydkVyb1BkYzU1?=
 =?utf-8?B?MmNiWlZER0VRRmFaK0UzdHRpMkFORHlGMldVdE42d3k1KzBxL0Nmcnc3TEF5?=
 =?utf-8?B?YVoxWGExU2paTTYxSDRYSUxtMEJXc3N1WmorSjNJVGhoMUFNM3ozalpNT2hj?=
 =?utf-8?B?QkVMRGdwSXlWb2t6Qm50MTVQT1pCTXV3WnY1bHprZHlLTi8rMDU1TFhtZEg1?=
 =?utf-8?B?S3g2ZW8zZFgxbmpVTEFackpSa2lxSXU2QnEremFTdVl2RC8rS0RTWW01UHFh?=
 =?utf-8?B?TU9oeWErQ0JnNXN0VEcwR21JOUdiTHpIMkprNitzcDZHVUwxUUl2SGVzT2Np?=
 =?utf-8?B?OHRmeFpLYzVPQTArZjgxQzNYa0NCdDZacVM4cGFibFBZaVBnQmdwTGdJeUtt?=
 =?utf-8?B?OXo3MlZoV2pWMXIva1g0VUtRWGl0STF2aElad2d3b2EwSU9hQVRVbXZiUGhx?=
 =?utf-8?B?cU5hd3pQbTFkakVJM3JwaEp1ZDM5aXNmNm9GT0NKZEJRUmZNQ0k1T2pPNzRi?=
 =?utf-8?B?UXpkbnRCQ0I0Y0t2OUVoV1A4Z1VzR2QxVkhMZzNvYjVPQnFqUjhTVjJQRGNs?=
 =?utf-8?B?VUcyQlJya3VPYzJZbHhkRGE4U2VmNkNPRko0SStQck4xdEpWVkJiV09qQ20v?=
 =?utf-8?B?STh4aUdGY1ROL0xwZ3RQcWxDT2djNnUyVC9Ta3p1WGhPVWZEZzJmdUc4VnEy?=
 =?utf-8?B?cmU4TWhTMVllVDk0U3FQaDZMN0dsRjdMcUxyeVRKSE95WTBPZzBXb3d5OXNU?=
 =?utf-8?B?STVOVFNtWmxFaUZZWUJjeXM3VW0vOE4vY2VVZDIvY1dSQU4xQlVYY1Z0Tmpp?=
 =?utf-8?B?QTZPbUUwS0piRHR2bE53T1o0clh1YVIvbmVtNWhBMXdJNHFnbUo0eTlSQzBM?=
 =?utf-8?B?QjJaa2pKUXp3R1hCcDB1SThWbEJCeFpWWnQzcnNqSldvV1lXS3UrMWV4YmJs?=
 =?utf-8?B?bzVWYUIrM2xEdTJzRGE3aWVhY2w4eUJiU2lYNDhVaVFLWmU5Q0EyUWNLVzlL?=
 =?utf-8?B?ZlV4ZGdKRmRZRW4zVHlDTDhOd0NzNW84N1AwMy9abCs5dlY1ek1JZXcrTnhK?=
 =?utf-8?B?S1dJRG01MkQydlhHRVcrNXBiVmJOQnErVVJNNTd3TUdaZDdMSVJpa2hKcmN4?=
 =?utf-8?B?QmVBV2taQUtWNmg1WmxWaFlZQnB1VlhTYXJkYjV2MnBhTU9lMHR5d0pjUlA5?=
 =?utf-8?B?VDExczh1NXFwZk92Q3hPUVNPR1pPeGo2Y1h5QWRWaEQ5N2N6SThMT05KYXJa?=
 =?utf-8?B?dnJ6a2svNmNOWWVDQ2gzbkRsUGJCczNZaDFoQmNBYy96cmpPUDhqK0sxeGs1?=
 =?utf-8?B?OXJZRjB5WjFQRDI4c1dlalFQSVhPdDVESlRTWEJlRXpKUlpvTFo2ZkJxMWFa?=
 =?utf-8?B?cGRlOElQRkpjakg5eGVDL29xZWprMlliTEZiMHRMN2M3Z0FoUGdUSGtuSkp2?=
 =?utf-8?B?VXY1V2svL0N2THJCM1RQUkZZby9MaUpMSGJnOTFPTm5wUk1jK0FVTXh4NGgw?=
 =?utf-8?B?UDd5M2ZKZEtITmlnL25wMW0rQk5ianpQSTlzNldJdTZ4cXlKby9yMHNZWGxN?=
 =?utf-8?B?dSt6ZlVONng2dFdXcFZpN0tyejFPdEpHZThTR3RZQXc3N3NJUmg4QUpoOWI3?=
 =?utf-8?Q?gBmNGxVJX8Ry86vad1OU7IEQXZJljcPldUdg8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NSs0cldzUWxrQ2QwQmQrd2tQVDlTbWNSa2ptaCtyMFhoVU5FZ1prYmhoWWRs?=
 =?utf-8?B?Y3pxSHJwVXNDY3o2U05VSGIyNnQzb0t4c3N1S1ZYbVZEcEpMY1dFTFl0Y0t3?=
 =?utf-8?B?VGVFaEtjOGMzTzVmYi9EdnNMU2ZzTFRVRDE4SThnZEwzaE81a0ZOMERqYWFJ?=
 =?utf-8?B?c2h5ZU5KVDJrUWJlak1BMXMvZ3ZYbUVjVVBKNWU0K0MvcTd3aDROQUYwUXFj?=
 =?utf-8?B?ZkU2UHpXWTRMRGpJdWNSK29JbVEvdjdUanZtdEhXN05hcGdUNkw2cjNlZlNC?=
 =?utf-8?B?cW9aTW9yeElDcjRLaER5WDk3YU4raFJZMFc4dU1xelEvcE5SdHFNRWMrZUlv?=
 =?utf-8?B?elFMQkEvS1Z1ZkZYd3JyMHJaZEZaL1NGUVNwL0NYVlA4ZmZQTUMwN0dtbElz?=
 =?utf-8?B?ZndxNHZxZGxMcE5MRG9FeUpQcUgzRjZjamFZRXFVUHVVczh5WmRqVEtSa3Q4?=
 =?utf-8?B?VkxSSmlwa28wWk1qY2U4a3lYdUxrYTZJNk4vajc4V3FTUnNiazJTcDVINWk1?=
 =?utf-8?B?ejhBUUFEUkFLZGk0dmk5VzhtOElEMElmcHdnUkpncUJzU21JdHVOdFhaSGsv?=
 =?utf-8?B?d3F5aWJLcTBVamlSTG1CQ0ZmcE10UzdWWlNZVzdicEFCR1ZXZVRXUEpqUTR6?=
 =?utf-8?B?b0MvY042Q1YxRnFrMVVBRFBOM0xibTl6QnhzMEx3VFluSEg3OU5EcUlYbm5x?=
 =?utf-8?B?cHJHVzgvWWs1dk1SVW1WMzNxRFFjTlY3dnhNSFpuZEhNM09Ca09seEdWUHRj?=
 =?utf-8?B?bVhUYVMzTjAzRzArY0t5NnRVKzdCelovQW81WjhMUDRXamgxNUMrOW82NXZV?=
 =?utf-8?B?QXMrOFpGK2dkWGJoZVFJc0ZZQnFTTThXRFVDV1VRbWk3S0JZWGVpUENTS2xU?=
 =?utf-8?B?anE2YUQ4WW44NzRUL0JuQ0V0NnNTU20xcFhza3FXUEJQMXRsYzZiemtxTHpt?=
 =?utf-8?B?R281UGZqV01HdWJ6L0IzeitYblhRc3dSai9odEpoK3hEQ01HUDJtTEo3Ym9J?=
 =?utf-8?B?SkJIT0lnaWZMZGRQQkxKMnhxN1BoNVJiT1JtRmxoOEw3TTBBZWRYaWF1dEtB?=
 =?utf-8?B?UXNwZ0hjMy9MckFucTQ3TjlNRGFjMGd0eXRVNzBuaTl0VXM5djVHS0s0NVRI?=
 =?utf-8?B?NVBBb0x5bVpmclJSU1FQNTRJMGIrRVh6Zmh1ZnZrS2d1TUVJa0RiTUNSSVQ3?=
 =?utf-8?B?U0RFcUUySm9wVit0WGpybEwvV3Qxa3dyb2U5dGFsdnNjek03bll0bE9hcnlO?=
 =?utf-8?B?TTdnZTVMK3hLczNPOGlrdmFqMmFyYjZhMmw4RVdaTDd6YnZBY29yU1cvK1Vw?=
 =?utf-8?B?bDk2SWR6VW1wSHBHanBEZjFNaTJTOFlIMGRJRTgzdGNKR3VSQURFMkorL0lq?=
 =?utf-8?B?cFpKOGR0VHlRNGtpOHMyK2x0c3I4cDlEN0Z3c25JMkRyeDZiMXFSVjNyOGhS?=
 =?utf-8?B?L3NjM1I5THdPTGRiTWFuRVp5cDF6aGZUMURPbE5uT1E0Q1NIRmNuamFRK2la?=
 =?utf-8?B?NTFkL0ltWWxFM0tkd2c4N2RkbDA3ZzJjRENjaDk3MkVTS2ZZNGVSamNwSFBK?=
 =?utf-8?B?R2VIUldOMDUzNnB2WGpSQ2xrZGl0enhHWi9FdDhiRjBuZWEzeGVVYjRCM0FV?=
 =?utf-8?B?WlJvV1ZacEtUQjhlUm03cUZqUkpyMVdGeTkzNi95ek1pMSt4OVBCTkZERi9C?=
 =?utf-8?B?M1NCeDVnb05KWFo2WFROcWVGM2VjTzhZa2U2a0lHd3o2akc0V1pzdEJ3Q2NJ?=
 =?utf-8?B?Q1hDQnNjUURhdDl5aWJzcEQ5aHNWRHdFUFBDVVorUHNqSzJQcGRqNzZkdXB1?=
 =?utf-8?B?a0YwL1lVTXFEU1VFcENEUTZCazhNSk85Sys3SldTVHBxZHlpNW9HWmdNb2pP?=
 =?utf-8?B?QnpGZnhrUmtFKzRQUWpiZlp3NVM4dmwyUi9OSVJaYzlSdjc2eVFiQ2dBZ3ZE?=
 =?utf-8?B?dm9kQ2xwd2pmWjcrbGk3V0dDaVBBNkY3c1ZmNjlUb3l0NkZPaVMxYXBRak1q?=
 =?utf-8?B?ZVNBL0Q1TFpJSStDa1BpUm1rNkUzdEt3YjN2VTNIcXFVM3NBU0hQaW1xR29Q?=
 =?utf-8?B?NnA1QXRaSGh2YkZTbnlmWm5xTWZ0Vm5XUWM5NXkwbXFSQlNWOTQvWm1Yb0RJ?=
 =?utf-8?B?U2lZd0ludm9JYXhwSXBUR09HMDM2NmU2aDBjTWZxNEowZWt0MjR6a3dIcEZi?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 856275c7-dbbe-4023-b90c-08dc86079cc0
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:04:03.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IkCvwTHuMuwBHZVRZowskuI+VYeSP0o543DVUKeg5FlP2Rd/jAiAzy5p87r6aJ6sPVT8QSm4Y5DYCEeb/paOOEB8o4WXQ1cDgPD4LZbq37Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9513

This series makes some minor modifications to the firmware update
mechanism, mainly (but not only) for the tps6598x variant.

The modifications are the following:

1. Use a single call to read the "firmware-name" property. The current
   implementations (tps25750 and tps6598x) of the firmware update
   mechanism read that property, even though tps_request_firmware()
   already does it.
2. Provide the same information via error logs for the both
   implementations (firmware name and size missing in tps6598x).
3. Minor code cleanup found by Coccinelle (min() instead of if...else).

The series has been tested with a TPS65987DDHRSHR.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (3):
      usb: typec: tipd: drop second firmware name read
      usb: typec: tipd: add error log to provide firmware name and size
      usb: typec: tipd: use min() to set tps6598x firmware packet size

 drivers/usb/typec/tipd/core.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)
---
base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
change-id: 20240605-tps6598x_fw_update_log-1d181faab2ba

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


