Return-Path: <linux-kernel+bounces-201864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE68FC45B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528EDB2AF3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AB019147F;
	Wed,  5 Jun 2024 07:17:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2119147A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571824; cv=none; b=QBZOprLhjl712/wzf9FdCsKsdQHBYuQBDbRWDMaagwxBTwzIWeqldQlsNC081Vsco1fWnKFW4vJuWHsJpzK8/6Ax5Dp6j+0Teb4r6GLY08/HF52ecpB/dtP46VCIJ4YSDUkEJ2DvPVBNDZPoWtWTRqs85FWWt8JUY+NgnwT+EYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571824; c=relaxed/simple;
	bh=dTCw0Zsw7agtCvfLxz5vt7fNHp189cjtYP+duWVwhdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R/RdvvjTVzRoJUUGoZpvx6+ta8mTsMzd0OyfzyWEi/osCjQce4OjrYjf29p1R6GT0P5B20bj7h0Vcn89CSUDVGb58FoOLU4xoln6gtSd3P7o+awPAdIfsggJ+0Z1l/P/QqTW+tnM+u35dehWUEHd9eV4hGqXa83kQDMCVU3w3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb32c26b4aso162269639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571822; x=1718176622;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxspU1ZmRks/0WFiVMt2n6PUL1lYRMaZgBqgc0EFSvg=;
        b=TdLeF8byknWFaOBLmEmCGAq+Ga2Xj9N6AFYHQqS4AwfssHW4WsrhOTs1E90KgDfxFv
         /YM+5EN0MwaDYEmw9oBR685lg+w1jTxyrFtlSxYgcIrUaFWPps8+1J0AIKP6bxHanAa4
         IPv5bbnLWfK/9a5FOo7dprKSC1IQbC/+nUCTNuES6YD2IEwJ796D9hbVfiImEBaY2oZI
         b1P55dr2DfrJiyLnvs8Ss3kbfAk03cEDMbtx6dFDys62oMW+rRvQzJOD2J8O8Jb7IDjP
         /ARHHJN73Ni5M2qs5jQ6Mj51JSyX34lun5eJkr/l+oElEs3cvuDUl/JuaziCQYwWjbwv
         oC9w==
X-Gm-Message-State: AOJu0YwvUARKyO0RuGLI+/Twh/Vs9ex2bXMZZ687eHLlwGW0a/Qh4vuY
	yelvDb1r+o/LcHf8yf4aV8wdgJJL+jBg3O375saCyLwQS3D3tH7CC+F6z5xJrDIroHjEMQmVUL6
	53kQNCoom4Lq2lcWiKcju0AWkH5YJwtdlCIjj868OfDIavGtxobluSfQ=
X-Google-Smtp-Source: AGHT+IHDt5y/QkjhqYY7rdCvBGHKz5UBNwLADYbgo/oSZSQuBinYw3PLu1vDpAueQNdP3dMfVMO4ShAm9mDaOs49kVIp+FSteB+6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:c545:0:b0:488:75e3:f3c4 with SMTP id
 8926c6da1cb9f-4b63be9530fmr25672173.4.1717571822148; Wed, 05 Jun 2024
 00:17:02 -0700 (PDT)
Date: Wed, 05 Jun 2024 00:17:02 -0700
In-Reply-To: <PN2PR01MB489171CD7B0E226F8256C23DFCF92@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055ee14061a1f5a2c@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://github.com/torvalds/linux.git on com=
mit e377d803b65ee4130213b3c041fc25fdfec1bd90: failed to run ["git" "fetch" =
"--force" "--tags" "aa24f7914cebcc04de6104c814c089815e172c16" "e377d803b65e=
e4130213b3c041fc25fdfec1bd90"]: exit status 128
fatal: remote error: upload-pack: not our ref e377d803b65ee4130213b3c041fc2=
5fdfec1bd90



Tested on:

commit:         [unknown=20
git tree:       https://github.com/torvalds/linux.git e377d803b65ee4130213b=
3c041fc25fdfec1bd90
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d7ea7de0cb3258=
7
dashboard link: https://syzkaller.appspot.com/bug?extid=3D9d95beb2a3c260622=
518
compiler:      =20

Note: no patches were applied.

