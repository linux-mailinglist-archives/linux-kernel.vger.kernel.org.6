Return-Path: <linux-kernel+bounces-566047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C61A6727F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3916717DE7A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A3209F51;
	Tue, 18 Mar 2025 11:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Pb/avz7U"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC493207656
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296940; cv=none; b=rzZuwtX7dNehdX7AonTz2rCTerX53973BevEjz5/TL3UXwXN7OdHH1hzXkqMZKgSNuZ7pNfGpGonacTozTNT7EqhXfC3bm7JZ5++mGQKE6QwR9e1QDFFQJkTgqiCbiPEk0DelxfawbMpEx27zMX7zP7qS3f2sHWq+isev7NCSR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296940; c=relaxed/simple;
	bh=AzupuCmBKbXzpVZpmNKG8W/iWTDbDRRSsor7u3gyJRo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=WjT6tmSHwepN7ebVfeGIwYG8Ep+QfCUqoxAi23OCL545uioVF8mdnHpeTgxMHMenpZYCw9nYLA+zgZBmpyYG4etNcMjRYtmJyhfTJL6eiIcUt5sLBFWP9UZnI2YWH37IqjWQEL7U4Ns+XglFcEH40iDCyhvwhfeTOHSF6c3gnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Pb/avz7U; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742296633; bh=oZEfS1bNjMZkXP6FUhmebj3gfnVYJH0W3uaf7UKOF0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pb/avz7UiTtT2he3iAmEL1HzLyehalc/XJd8AmvgllDzDPTz4RVSI1g3mzcLKa5cT
	 e3jnCi8qrju3NGeY7oCxrFtBLf+BjLuOxjXrDqKS+onoAzcsEWSkeAGcqBgqj3kJR+
	 aOs24h1ixltXIwzwbzxBBGtNsxN3vLKTP8D1tjQA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 44A96096; Tue, 18 Mar 2025 19:17:10 +0800
X-QQ-mid: xmsmtpt1742296630t1572ysac
Message-ID: <tencent_0260977E366A4A26744576D967063D013609@qq.com>
X-QQ-XMAILINFO: NRWf2ABhDVMHcT4RxQxm55dlORXT/07+7y75NZKRr7AyH8/TyoTplfa7+45mAh
	 51sCLQOM2bw2LzgBDsoeEKGV0e7lwCj0LPQ2qLeEprp/CXUmc9GLMHIUrej2Q6MQByKCM9ljuBX7
	 bvLuH98WoHBhDTsSI8Pc8SkMbWSk4RwHDWYt7pFf8jWwXddM2I0Nd/fqdRiN7/zVVZT6+MVqgm2d
	 uj7z3SlQo3O0/CfU02iuJamEtNNrQxXJaaiVLgrJT5MmQr78FRcQw6o6mlbOsXuBbzgOpICU55Ay
	 Wx91QHdoQxliD5cZW6CkIvFizoRzEBmnpo/kd1u5eSxKfLBWz9qZj1m6qwOHwbhRtZpK0EPH8hi3
	 eZyI0l5yy7YZ84UtYTFdWPHyhwYYHiQoQyERTKO6BcAAiX24+5Is0Tcw7Bf6MzwMNL9ws3KOG1q2
	 gwHWMCVgOIXxy38kyTigptjBM87BuyLGITpZNsNOD36k6YybeaWGFd63PUJZZeGTiMF27hRgOrz3
	 aL73HBgCuAVqKYjroZ/loJazUTocAKZqpTeSE7qhNwDfePLuewH3ML4+4YmpOBMk25wVvj2vrTNk
	 ZLrawyMVYssQtTVJ6uZgZoI/g3ZZjEk1cnsXVAhZjp+O1vZ7J6iWAgtVqDD5dqY0DQzeHUSI4gQL
	 hQg5pggh37x/tj1ApqzVr9IXD/r3Cq3RJ2PSpYEjvk9Bfae+Tldq1wFMzbZca29LBQBv7crZP7UC
	 fwpO3QI8T/tsd0IVVMQwJfn57tvKRZ8aRzufqyezUD4A4mP1f9HdlNUYNwBnJxfrWsRmkm55YTKm
	 JW3NByRhjAHJCqm7C7NeQPQtsjhN3NZmzDidoYN3FMs4mykb6D4FCe+M8pck8XSxssDJh1DvHS/m
	 +1HBT4nbqr+KV8kZB1OGlgWM6oiECIY22WqFoxD/4qbjpY1pv1eb8+lReIX56C94zSeS+k/BjarU
	 ZCcCi41fE3DjMimerrSQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: dhowells@redhat.com
Cc: enjuk@amazon.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marc.dionne@auristor.com,
	syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
Date: Tue, 18 Mar 2025 19:17:11 +0800
X-OQ-MSGID: <20250318111710.3589229-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2477988.1742293427@warthog.procyon.org.uk>
References: <2477988.1742293427@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 18 Mar 2025 10:23:47 +0000, David Howells wrote:
> commit 3ce74c88a6708de1842dbebc10f83013718324d0
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Mar 18 10:18:29 2025 +0000
My fix already sent.
https://lore.kernel.org/all/tencent_8CA5671E3C533638973237484A0874917609@qq.com/
> 
>     afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
> 
>     Fix afs_atcell_get_link() to check if the workstation cell is unset before
>     doing the RCU pathwalk bit where we dereference that.
> 
>     Fixes: 823869e1e616 ("afs: Fix afs_atcell_get_link() to handle RCU pathwalk")
>     Reported-by: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
>     Signed-off-by: David Howells <dhowells@redhat.com>
>     cc: Marc Dionne <marc.dionne@auristor.com>
>     cc: linux-afs@lists.infradead.org
>     cc: linux-fsdevel@vger.kernel.org

BR,
Edward


