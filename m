Return-Path: <linux-kernel+bounces-337470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC74984A78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EC9B22FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A31AB6F5;
	Tue, 24 Sep 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="NJ38rMb2"
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C44C288B5;
	Tue, 24 Sep 2024 17:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.137.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727200441; cv=fail; b=Ec9YFzGUISEhOl9q6znEqANTBo56xnmMzaCVnJIf94bPaJIIjsZl8HZ0VEtrGq27ovy5d/FrvYjLDdKmlmo8PUCyC40nTlzpH1cb788C3javzAxsdeWKAvrde3BWdV74eAv2c9/NuBjZjC3le6zecanoz1dMLziOK+LLnJqSKzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727200441; c=relaxed/simple;
	bh=zXIV7Kdu77q/xGjzNXT8NqlzeZzrQz9ZDvf3eKb/gA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QMRrnde2QqukAyIkzlQjDPE51ZQ0y7mPKXOJdxDKNDfEypi+IQHmt9KtLj3XiQXtFMTihxUGlYF3A4HBmSQRGH9SGjIDJFhvF98cpVOPkmwTtdDzqLhjCMzUzk2RbpCTmz58jqkiDHoOeUmvajryHGbXkEMtc6CxjskLsupVNFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=NJ38rMb2; arc=fail smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OBIvlj027162;
	Tue, 24 Sep 2024 10:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	smtpout1; bh=ke6dEs3SSTFmU0jZHY+mGqQVog5xW0wHo9QgTQwGMkA=; b=NJ3
	8rMb2nnXtt7IaZUySiEgC3utfLl+QxX5aIO3uBqVpSFST5XV5PpHQM2F6PWoRFsa
	afAj+QULdNT1oUa8u4VtakBhpHEQ3auBECMg4STfDynItXRTVjsZJrYG6e4wIcfx
	RSqrbVKFELzs57//4bFeLOpLhvu3ZVNdWil0r71E9Apcoslax6YCbKHK7FMPYoqT
	lcLmI4HqwT0CjGa5mjuud36/9cgGx417xca1pHEVc63YNXeCU6IyxE0F9u4zn+d4
	JCJtlxTyk0G4Upb5RPBxqT0Sqq8kuAA2QdLhIgfRurS++R2AHLeOccD9+76y53FC
	HgtR9YTX+jVqMwHXXFA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 41ssc84964-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 10:34:25 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAkSlQ018002;
	Tue, 24 Sep 2024 10:34:25 -0400
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 41ufnnmdgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 10:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMq08IFpcr1UbOEm2t7Bc0NcxBwv+xSWrJpeWFDzHFPeZBRJ+0kJAKWq0Odvl3N+wDqrBmaGQxGLKmDT0XeQoi2UqgIV7Crxg235+OxvfzkbmFKKBEajXbc08JbFBM7xuThy3QfQYByv24cgdet2nWaxTXusr3IZ8tD3KyOUfZRhui8oR/fhDcbAy48V9IMrYHtNPJ8EqV45sfr16VLZq417cZytHUCvHO7JZ1Hfg6ycEkiFOt/NMTq+POXQx11np5d3zIYW2FOWuolZkcG3FivaPCNOSKOrR43A/TKK7YwGKS9BCVgZdGWWS2sRy2PsdrVLZHjUxZMi3GhDYTHjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke6dEs3SSTFmU0jZHY+mGqQVog5xW0wHo9QgTQwGMkA=;
 b=QefkQjgQN4Jeb/87/1u/f5nOjnuxgbqd29UuR6KTe1RfQ3/GJ35f25SH6/igRxEsV40a726C4lapUQhoielE3uNr6uTRKpm1JZVmVT1XoY3yQXUn7ydRs919ruqbem3DIIj8GJ6A3AJWg8hxnTUI2shphnkTUYvckhUGAVZ3LJDca0Y8nKP/s77B85TMH5b9WsUOMvEs8XrHZJJ17T2OqioaqCzqcGpsCOk9qgKfIMq7KbJSKx2dy2jo+1YJFmVFGOmsyoScSUJYaO7fGMc3ttOUUStCIs/zyw4bgJ0/oFcJ386sDQddI+ydS+fJCoIKAuKcWJu9VutOveyMTaFrJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CY5PR19MB6147.namprd19.prod.outlook.com (2603:10b6:930:c::14)
 by DM6PR19MB3834.namprd19.prod.outlook.com (2603:10b6:5:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:34:17 +0000
Received: from CY5PR19MB6147.namprd19.prod.outlook.com
 ([fe80::d390:13bd:b078:f743]) by CY5PR19MB6147.namprd19.prod.outlook.com
 ([fe80::d390:13bd:b078:f743%6]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:34:17 +0000
From: "Tudor, Laurentiu" <Laurentiu.Tudor1@dell.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
        Crag Wang
	<crag0715@gmail.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>,
        Hans de Goede
	<hdegoede@redhat.com>,
        =?utf-7?B?SWxwbyBKK0FPUS1ydmluZW4=?=
	<ilpo.jarvinen@linux.intel.com>
CC: "Wang, Crag" <Crag.Wang@dell.com>, "Wang, Crag" <Crag.Wang@dell.com>,
        Dell
 Client Kernel <Dell.Client.Kernel@dell.com>,
        "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Topic: [PATCHv2 1/1] platform/x86: dell-sysman: add support for
 alienware products
Thread-Index: AQHbDj84MXlbZutFFUaizZvriNyv9bJm7agAgAAS3cA=
Date: Tue, 24 Sep 2024 14:34:17 +0000
Message-ID:
 <CY5PR19MB61479854D62CAD389C99BA15BA682@CY5PR19MB6147.namprd19.prod.outlook.com>
References: <20240923063658.411071-1-crag_wang@dell.com>
 <20240924050302.317522-2-crag_wang@dell.com>
 <0a31cb22-e3f9-4212-8fc1-77d6cafa7277@amd.com>
In-Reply-To: <0a31cb22-e3f9-4212-8fc1-77d6cafa7277@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=83462e2f-3ea9-434e-8041-cec6fed885da;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-09-24T14:31:56Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR19MB6147:EE_|DM6PR19MB3834:EE_
x-ms-office365-filtering-correlation-id: 42c4cd05-e286-499a-190e-08dcdca5f893
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-7?B?bzZjdEptVzFGeFJJTVVLUUc0QnViVzlMZ0djckt6dExPVUg4dE1jaGZtbnR5?=
 =?utf-7?B?ZXRpVHU1T05rMEpaclF5YUMvazZLRjJNRXJTTE94am1tMFQyN1EvbmZhNzJk?=
 =?utf-7?B?OGNsNEdrQ2F6NVhhT1RpdlF0TWJkKy1rYWt6SEtrb1lselVxZnBlOFJLVm9Z?=
 =?utf-7?B?a2NlMHFWaXBuRnlsWUNBWEQ3MTZiVHc1VXc3Q2dzbkdURGdJZGlxeHNFeVE1?=
 =?utf-7?B?QVR4NHF6ejlkbGROR1FqakJYaWt0VkVqUjg2SjM1RFFDWWdKb0tabGdmcWEz?=
 =?utf-7?B?NjFqTTBreTJwV3VRRjg0d3U3NzY5WjJmVistQ29vSEpCZDJUYjlOejFGL2lr?=
 =?utf-7?B?L0tiU29mWXJCL1BBVGl4eU52OHorLWdaV1YwaGxIUDlUNWFITnBxbEJSeWxY?=
 =?utf-7?B?R2ZhVUk5L2Vtb0lDdHVBbG5LYnhkR1YwZEhXQTJMSzZRL094bEdyNHFqTlNi?=
 =?utf-7?B?SSstNWVDNE15WnhXQWJzZFg2U2VxNUhlSm1HcGZUNWlMUXJIWFlaYWo5aC9h?=
 =?utf-7?B?cTV2cU9hVndvYkdGY3ZsaWhWUFp0WFcrLXoxTUVzVWxaQVZSRnQ2ZUdKa3RW?=
 =?utf-7?B?L3MrLXVqc1JHbTlrR0pwNUZKT21CKy1XWkJnMUpiMVEvemljY24vdFBJVGJH?=
 =?utf-7?B?Y0EvNWw0TWx3OXhTb2p3MTlRZzZXTjQyQkIxWW52S08xVWVpdjBZbi9rSURM?=
 =?utf-7?B?U0N3ei9wRDZoODRKeFN4UG1zNENFdXBQaWVWZnF6SmJuRGErLVFJYystTGRL?=
 =?utf-7?B?OGdSOWxrbDZtYWdkMmZ4aGtNdEMwN0MySXJFUW1GRUlFc3ErLWJiQmg5RnA=?=
 =?utf-7?B?SCstTUJKSk5ha2E1dHZpOHpmVE1zYXd2UjFyb3pYZDJWYzBqY3lCdmxvQTRr?=
 =?utf-7?B?a2xRc0lzY2J2VmlKKy14ZlJNKy1kTkdZOXdzQ29MaDJOYkVhelFGUVVDQmtZ?=
 =?utf-7?B?Z1hUVHRrUVpCNkNPemRlU2hTKy1ZZkI1aVBCS28zcDVNZFd2NG9JNkllRWFm?=
 =?utf-7?B?L3cxc3pZTy8zSlFHcVg5Rm96RWluOUMycXlXV0lYQWFXUXVwQ2I4azRQMjRU?=
 =?utf-7?B?QXJLU01VZWx2V0dKUlB0bVBXQk9uZ2QzRTNWYW82WnMxbmJXeVJRZHYrLW9p?=
 =?utf-7?B?RkZLSnBJT05FZHRnTUVPL1NaWmVsUndHZ0xudlBFRXRVVnVac0VhUS8yL0ky?=
 =?utf-7?B?SklHYjZJUGxsWGZ6ckJydGlrcmRFNnhCNno4MTVxTHVCQmRJWTRUMlh3RDkx?=
 =?utf-7?B?R0FPY21mSXUyWExQYVQ4ZVFsSGhPZ1lOUCstRkQ3TnJXQzJQM2xKYk1mcWlk?=
 =?utf-7?B?UjVlWDRyeXJXQVJKM3NjY3dvc2pKdmp6ME0vTFkveGtiUEYzNHp3TDRER0xB?=
 =?utf-7?B?aU5uOCstZlVJKy1uSjZHaG11Sk8zdUdSSHUzd3RobmkxMkdLSkFVVGtyTVk=?=
 =?utf-7?B?Ky1vQzBhbFByQ1dka2lveWFMakdjWmZHYW5Xa1pvdDFWOFBYYVFwQlRvTmEw?=
 =?utf-7?B?UjZBczVudC9xN2hVNmk3bXhzb2VVTm1XYUNHTFVzQ29SNXNrcko2RVoxRlpV?=
 =?utf-7?B?MGJpSWV5WkpOKy01SVZMWkZlOWhhNk95dUZqVlBlM0Z5aEdMZENHT0ZUNjVG?=
 =?utf-7?B?SDNWbElMS0Nnc3k1bVFVc1Z5Tk1oZXBkOXVpa0orLVd5bjJxbzQ4MUxxd051?=
 =?utf-7?B?ZHIwdistMmFpSW5SdU4zaWxkSWtESGZ5dk1pRS9KOEJMMzUrLWlUN0FnVThx?=
 =?utf-7?B?UUxLKy1yc2x2Z0hSRk1MVkFYSzkxaXcrQUQwQVBRLQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR19MB6147.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-7?B?SWkzODlTV01xZkJXMmdVKy00SG1NeEZFT0FEYi9odjZCVUI4Y3ZoZ29WejVy?=
 =?utf-7?B?WXB3RWFQSzRnTHJKY3BweistaERraGJSR0g2Y3lGQ1RuZ3JzYmh3eFZMR3U3?=
 =?utf-7?B?Q1gyckRyWktudFhuYXdKSkR2ekRoWnBKWVJJZkw0NlFYN0JjL3NlUWV0Qlpo?=
 =?utf-7?B?S0huTkhGZEdCelFRaGpQOXZzMmlUblY0L3p6TnRHR3J3cVRCNjk4N3FPKy0x?=
 =?utf-7?B?VTh0OUtGa2ZaV21TY1hDVVpBczJ1cE5FOUZBMDZPeUFmckEvazFoRVVlUDlv?=
 =?utf-7?B?MXJjcVhwVnlZODNRb2paNm4wbXBYRXd6UkM1eWh2aGJSbWtoNWQ5cEt5N0Ev?=
 =?utf-7?B?aTF1M3Y1MHdXbUZZampVSU5tZU9URDBJby9NdmE4YWw5dkxhT2s5aVZ6TVAz?=
 =?utf-7?B?eGEwOUhkUXVITVJEYkYrLVpIbjJQbWJPM3htUllhR3h2QU9mdjFEc3RZKy1U?=
 =?utf-7?B?UklFV05WRGMxbGdSOEhobU1lcktwaHFKeUJXOHV1WktIUVJCN2FBNlhYL2tD?=
 =?utf-7?B?ZVlxaEZibTdHMCstUWk3RDRTcHhSdW00SjBOUlJ2dkl4M29XL21jaWdpMjZy?=
 =?utf-7?B?aXRldnRCZjE0SDV4a0RWMXVtbUJSdWg1N3U1UlVVb2dnSVRXSktiYkc3cVZt?=
 =?utf-7?B?WjhXR1VGWlBEZnA1OERHZkMwRWRRcHFJeWJNWmVtbEx0OEQwS3F4UDJRKy1B?=
 =?utf-7?B?Nk9tdkQ5N0szbmVINEl2Mld0aU80aDFzTFFtOEhPdkFHTkkxeG52TGo4enB2?=
 =?utf-7?B?ZVQrLSstRWYxMG5veDJrUmNJVFFXVS9JQUR2cistSWxYazkwQmpMNVpFdll2?=
 =?utf-7?B?R3BEcDdJWWR3TFJDejZwcHkvSGJXWWJwblNiMnlGejJUaVR6bUd2MnlnT3ZK?=
 =?utf-7?B?OFh4UVA4RmpYMU9tZU5NSjZOTXlsQ3hOblBOTjBqblErLVVGL3Y4TG95NkNw?=
 =?utf-7?B?b0daMHlQS2pkcnFoSS9JeVhJbCsteG9teHFPUGxhdE9kUXpWVkFXTzhlWG9Y?=
 =?utf-7?B?RmFubmh5QU8zM2VsVmw1ZEhZU3NVWXBVY2lYbjhZTXhHVGVNMElNUk9icHVW?=
 =?utf-7?B?aXYrLVY2dnFFeXlvVUVySVduam9YNW5oZDZZbFhlTWk1SUhRUlBud2ZHak4z?=
 =?utf-7?B?T29JbmNFdGswQVdwckxjSWR4V2F6M2ttZDBxcnhIVWpZWG1hOUF1Z2RIZnlY?=
 =?utf-7?B?RDhqR3g2WjdVbXBIUUdIUmlxVmswdmRJbWd4cEpmR2UvcmxmQlZ4VlJKKy04?=
 =?utf-7?B?eGNJaURQeWtXeC9mdHVDVTd6dUYvUE8rLXM2b0FmVmMyeWxWc1hJcE0vYWY4?=
 =?utf-7?B?dmhpMXZ5aGJSbTk0MnNsMWxadFM4R0ljSXZYd2VIeXo5WHg1NFl3aGhQU1lQ?=
 =?utf-7?B?eUVpWnpIT0NEU3VTTENpR1dZQ2pmUlFPekxodjZIWFEwd256SG1ydldMKy1h?=
 =?utf-7?B?R1pEQ0liSkNmSlZDRGl1UXh0MDVTNnIwSUJHVmwxUjVwUnhGRistR1R6ZlpC?=
 =?utf-7?B?Si9FWVhjRkcyMXNHdUFHa0hCM3BBZURvVFc3YVVvSmdsbGpVU0ZVREhQU1VT?=
 =?utf-7?B?UGxob1VEWmF4R1ozeFBsWUZmd1pSR0RIM1REeklhaHJrcDVSZm1kN2toeFJ6?=
 =?utf-7?B?RkVKZXI1eDhWV0tsWDVBTUQxUHFOblBWNW5tT3lyalNSVU41OFFuM0gxVkxx?=
 =?utf-7?B?OE1xRystZWRDNWI0dXI0aE5OUmEySThvUkRGdXNwTU80Y0dCOVhhZzlzL2M1?=
 =?utf-7?B?ZEY2ZHlHMlpQYm1Hb3BlNTdETHBWbDZLR1UvNDVLTjYrLWtSR2N0Y0hJY0hq?=
 =?utf-7?B?UXRCNXdoeGVBZDBrUGtiWGdxRWV0blpCMHVyaHRzVEFtY1BhVkFoRWVkdjJR?=
 =?utf-7?B?alJsOTVZbW9XcjRNamdOUUlCeWlQRWJ4dDZmSmhSTW5OWTZTeTIwT3FYUVRY?=
 =?utf-7?B?U0xabDhFeGhHN1BOajgzR3ZiLzZwd2hiNGZhTzFXa05PbnNuTzFMblFIbmN4?=
 =?utf-7?B?UjByVmJFVjluSGZzNkRjV1hicVdHNVR0V1dQMk9kWlNOaGZ3MXZQOGowRCst?=
 =?utf-7?B?MFUrLWdtekhmbjg2eEdXWVlHcUxCa0lld2VIdWpEUEN0b0srLTdoMkRYV0Zi?=
 =?utf-7?B?MXZXdmEwRTQyRW5OKy1KbDZhSVFqeTNzTistdnFlYmJqZ0piKy1vcFJvNm42?=
 =?utf-7?B?anFyaTg=?=
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR19MB6147.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c4cd05-e286-499a-190e-08dcdca5f893
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 14:34:17.7687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ogCctItEglyVJv4ElNffrg0Fsq+9c2iNTYd0s/WYZ3dXG9XFT857lD4xc4TCp5OzavTpIspAI49xdbUIKpanCo1ZjPgcQBRDY+f2NsmG5eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240104
X-Proofpoint-ORIG-GUID: _Rv8qbK_qYFmPos2rPAnR2A9_86CM1al
X-Proofpoint-GUID: _Rv8qbK_qYFmPos2rPAnR2A9_86CM1al
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409240104

Hi,


Internal Use - Confidential
-----Original Message-----
From: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4-
Sent: Tuesday, September 24, 2024 4:24 PM

On 9/24/2024 00:02, Crag Wang wrote:
+AD4- Remove the URL check and add alienware string for broader support.

Couple of newbie questions: what's the reason for dropping the URL check? W=
ould it make sense to include the reason in the commit msg?

---
Thanks +ACY- Best Regards, Laurentiu

+AD4- Signed-off-by: Crag Wang +ADw-crag+AF8-wang+AEA-dell.com+AD4-
+AD4- ---
Reviewed-by: Mario Limonciello +ADw-mario.limonciello+AEA-amd.com+AD4-
+AD4-   drivers/platform/x86/dell/dell-wmi-sysman/sysman.c +AHw- 2 +--
+AD4-   1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4-
+AD4- diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/dri=
vers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- index 9def7983d7d6..68c63e1fbd27 100644
+AD4- --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +-+-+- b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+AD4- +AEAAQA- -521,7 +-521,7 +AEAAQA- static int +AF8AXw-init sysman+AF8-i=
nit(void)
+AD4-       int ret +AD0- 0+ADs-
+AD4-
+AD4-       if (+ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-Dell System+ACI-, NULL) +ACYAJg-
+AD4- -         +ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+A=
F8-STRING, +ACI-www.dell.com+ACI-, NULL)) +AHs-
+AD4- +-         +ACE-dmi+AF8-find+AF8-device(DMI+AF8-DEV+AF8-TYPE+AF8-OEM+=
AF8-STRING, +ACI-Alienware+ACI-, NULL)) +AHs-
+AD4-               pr+AF8-err(+ACI-Unable to run on non-Dell system+AFw-n+=
ACI-)+ADs-
+AD4-               return -ENODEV+ADs-
+AD4-       +AH0-


