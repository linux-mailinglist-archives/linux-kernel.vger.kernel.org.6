Return-Path: <linux-kernel+bounces-543326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9FA4D44B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741D818908F7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D961F584D;
	Tue,  4 Mar 2025 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TCs02IXk"
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C35194080;
	Tue,  4 Mar 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072196; cv=none; b=SCbcqokwu4a8/SyBueNRzsHQUcDSpEMoWl1h3JHvjiiSCAEpb9nwOE0LSAZQymDTpqex+QQEpjI8gpCyAzHaqRdM4fDB54wW6urOWnc0jK4n71bRKTASNDdkp4oPfx+9aldyvUxRIrfQBF1EtY9YeWK9okKdAsxin+h0IMXsrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072196; c=relaxed/simple;
	bh=ZlF2kx2Q5sqKKFm415Ur7QAC3/HP58PNS0TRB5CgCbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T8easJf2rXxHUPNJNsLeNUyMYJBiCA5i5/q6NLGi1uULVBVW7ARi6pgCXLCfnXb3jncxSCNy2nTD1Q9F13yQfVIUqrf9Chg/hGuBZwkmmpHWqjV1m9IYI1Uoo8/z7Uyqdr8KsJrjf0mIvOoLE+N8mU661VlWVP4FxxAs5eP8sos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TCs02IXk; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741072163;
	bh=ZlF2kx2Q5sqKKFm415Ur7QAC3/HP58PNS0TRB5CgCbk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TCs02IXkEnZZoqgpaJft5j6NWDpRCWB4PATyWdlKdzNNKDlgGSbvuNmcBHqUzfe/R
	 yGbKH3C92BarpiWns5Pq+GfhftdNAEduE/1uMBTV2mgTI29g79GFKnwHZxe5ytpe1J
	 zaajVgAfPFGZbnwr7rikuDzavTP0QK1sAupgQ5aI=
X-QQ-mid: bizesmtpip2t1741072157t3v2ohi
X-QQ-Originating-IP: eRUQvbqFAYXE6BgAqDTDhjTKolsBh1jbfbLkNXCXaUw=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Mar 2025 15:09:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7794148530895262856
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com
Subject: Re:[PATCH V2] usb: xhci: Add debugfs support for xHCI port bandwidth
Date: Tue,  4 Mar 2025 15:09:14 +0800
Message-Id: <20250304070914.3991-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: M613wnTrQKZbdlxMU2WwYGfKYkS0fOqpZZXCs88GDx6z80J76Q+Z5mr3
	vrLgy0kVPE2QK/AvO7AlY2G4Ly6T6bllmcReDp7Ya1w3mzlx+O9bbYnhWDNV1G0sn2bFM7I
	NAZaRI7HDxmvl1jG6lkR0QvHfEF9iv38UAonhDrAgvp/gbG23+TYd+1gLAtbzqO5Fks7+in
	5nGvnx62XLnCYG/iDbgH7C8nXmLDBjNJAgDnSJqLk0Mk9ihPC5QJe4vdvt65GEZ8Jr/6ipW
	Wb+QJN299x/GfMaa63vHW9XOmzstKYgI+kW0QIj5Mue9gL87hLAly+pfyK+ow+QdS9dbXVk
	fZNaihNM5NNBE9rnOXjsjnWuBdD6vNmzwcRBIFfSM87siEMgYw7rNKx7Uhe9Bz8m7rribOv
	TWM9TZzJ1Q4Trupt0DE/g1DhVd4yPhDzYE1UjyXY7gDB8w9xMjKvruq9IOKxcEJM+pGUih9
	LrcWlP83L+gN1/F5GEDG7i16FdWk/jD1WHOMB8NxJvJb39QG4lJ/37wTLo/oSc5ll2V7OU9
	l+9QBviapTeoW7G1sRBkWjxJae0KbX6Bb13BZZhGZH/aV6igxLEarc8OEcYfyDZGtsKY4Pw
	yLmxvRsKKTsRPti+8xefQjIOPEVn9Ujdu73O7SecxiQf0GunlTIZd+2i9D7CqMEvHSvtoC9
	6gKoyq9FDGqyxO9cWBHarUD6dWPVXueOnxr9RMKXy3xI1FxkYVdswQTQdUPhS3xs5ge7kIB
	xyqy37MRW9XbTEYaLHNTwlwLWj6h8cIgAUOlt4/0cCcQEjPdGfTndbxml7styL/+r14F6si
	05cdbF1B6sj1tam9vvn+4pg6m22azFb8wRKUuWHS5aTtN8Jx7R60SG0d31qXTaMIaXSyPb2
	QpxYtNuzmZRE9q8/8YRG3CXYN7w4l7iNp62g8m8G2qlNBggyRkcYBBfzNFlAWmz6s8CSMd+
	Fvoipd3kQtXzgEpteBKXxx7hsUQAP10XKfxqnYx6S/Fy5So9g5xZIW0dq4kJ2GLQPfFbETJ
	0m4FuTYAlNJUUPJBF+DX2r/Rh2WDLH+MfhPYUsYIObLSSGin1n7+RKdbGkExA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On 2025/3/3 18:36, greg k-h wrote:

>
>The subject line is very odd, can you please fix that up and resend a v2
>patch?
>

I have sent v2 patch, No code changes were made, only the subject was changed.

thanks,

raoxu

