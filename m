Return-Path: <linux-kernel+bounces-433090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD29E53C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2303B18839B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75F91F6663;
	Thu,  5 Dec 2024 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eBvlqOzo"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C581A1F5401
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397719; cv=none; b=EuX2ZsCxyMO1k7lOGbbknFW4okLbwMQOM3T9iwAcPDjVoj8CEWunVuv8wUTTpnsVEQxcZZbdYcvrXPF0EtiaZ8YqOAHI1Ar2/OgUEegviNR/dQhfZ3zvXNS/1LhDpe6W6jGGqLV2qaYI0F8kx1S8IXs9qi3Emdw0mfCsMgAzx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397719; c=relaxed/simple;
	bh=6m2UYaLFbL1o6VSAsvUm9KsfR3Fne8dcrCHlBjxWKm0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bdaq5hshx3dBeHNg3hrMsRZzr+vYx51GOkWzQUmxfrGr1WNU4f6G/QlI7iS/Xfjh8BD8NZcVwOLXpvtu5lNGimKjWFVcJXHfQ02n2902CTfWrvP0ooniJY31Rhg23WsmF5nsPutdvTwTEUMent7Yy6ugqTuwZRfIL8hPOO3TLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eBvlqOzo; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733397710; bh=6m2UYaLFbL1o6VSAsvUm9KsfR3Fne8dcrCHlBjxWKm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBvlqOzo+vrIiuY6fFqZDoWNqWLMSJKT+tesZ+1EMsA8T+ACHlQoc3QGqtEyPcCWt
	 jxYnEpL5JQ+UKNnynTxZdqL6Xyfp/9qWJZ/c68u/50ji86JoppoqkiWxrOSIn2qVkB
	 k097Q0Ovj0XjWm0Q+fb4I92Pbj0u87jwmnhnDHxE=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 3620205F; Thu, 05 Dec 2024 19:13:34 +0800
X-QQ-mid: xmsmtpt1733397214tm8i84yn7
Message-ID: <tencent_A85875C576B566923DD537C696D037284B09@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT7QSuRsaGlgaejpY+aBPh9By3mzpSxR6xROv90/idnbrBLeCqaR
	 B7Eo7XnA49HW92kRQ0afEiTgKVCQWEjpzzD1dlNAjiwZ67JOgUZsD4yAVIYbBbYjRZJSKkZKGkM8
	 xRuJcVJfQoHJSESWksKuVouhsPTYy0tOts+A0RvCT6fQV92u9RAFjSgdZOmyousqPIKXJGXzHhGg
	 x7SbBoL82ekM9besKfzoJe4hiCMYBiVoHIalM7OpoaPkDbLzTpxCczIECxo+Yxl9qu3+3ZPotC1O
	 Z789zNxs0EMNKhWyRY9Yuhi/mK217BExeMDFtkyODvyA8BafjVtFOoyV7F/yrv1H7bev2iGeph7e
	 +sTxdm9kNh5rpg4oIUo4Tb9fwB+sfNHKWwt6wjjLpBvD6ihE5oYWbVeDi8Pjq+nYtvv1grO/iWEU
	 TVqgIQ5SOkVYzIy/vUlDVI4DZvK96RTzcODvM9nhaz4pISOKfangVto53Yb4YGISdalUAJd5QsgE
	 bLglYxQEFlqKmDcr8YMk3xzMq+1l7HfZLIIpfbemCszp1VS4yjXXPnVdDQeZgwQ/nN2nPVYiWti2
	 cxOtRabPfAcytLne4qsY99Cg3yEhF3c8+2zV2UGkSHKbCblUrkRLsIAm1OCEZA9AlJ6bYDG9L6Zf
	 XpeLrBQ4LjOI08Z9NXNa7mhu6EjLAZjoasqpC7bCLCdokLQa0QZocRA1v8X3SDOPUOVaTe2avVHb
	 hPGkIgzYxDFJ/BoUe8YufyhvaLgLSkyoo/85YyVxZnspds7QEO4lXIR0uJbf+5pEiiGqaGTyaGYG
	 6MGG/UvXdIpSLNT7yBuZF2zFztdbBTBJI1Zd/EOXilLbxt90+6aXF/9ofR6jnpu3KhkWx9JsgVs0
	 oorROJ4uXk7MLRubDSdtA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9260555647a5132edd48@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_rmdir
Date: Thu,  5 Dec 2024 19:13:33 +0800
X-OQ-MSGID: <20241205111332.998470-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <673e20ae.050a0220.3c9d61.0163.GAE@google.com>
References: <673e20ae.050a0220.3c9d61.0163.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/ea1davis/linux nilfs/syz_0163_v3


