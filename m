Return-Path: <linux-kernel+bounces-287685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5F2952B53
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177801F215B6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626C1B142C;
	Thu, 15 Aug 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44NQ/Hch";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n6crkEUp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1BD29CFB;
	Thu, 15 Aug 2024 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712031; cv=none; b=ZXoojjdIj+CgVySp/+NoMcohlBsyisPWX5TM6c3xStGpIqHzFqdj9dGtIdEuZV6C6Xcyyzw96ouRwFLY576qAeCn/RRRZ91Yg0+LIueaQrX8ruvfINWYOqRRBoDTpnFghMuh95FrFqbQ6ozoOzMlcGeYWpBojBFxi9PPzNSP2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712031; c=relaxed/simple;
	bh=XQcoIaduwuccWjdCQClDPfInyE20Zdx9SbBaF+E0ypM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oYtiT2R5LeEM5Lnsm3y45gLIqvzgyeSrN7tMI6nia4A2sqlKCn2msruLJyuanqFDKvkPoA5ixd3TIjGVl+LTg8/wMMp7fsAOYvONlG8gF01axX/pgE2q/1TDgJWJBlA/jkXLc0xoysUrRiqmCzsQdxwfaAiBcDoUjM7cYlrXoEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44NQ/Hch; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n6crkEUp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723712022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maVLekNauL+jpDz+leGh246XtWlgDC9MP29oK4IiT7E=;
	b=44NQ/HchKK3iKxGkYe1BChOdPu6lvBL8EC0jw+k33niArfBmLSHtJXaRdv2eMgwx1Amc4Q
	Xvoi6CdbqsMQLI1rZuDuK5MOkHToDGJD0b6+d7wVll//5H89MqHjhGij0d5zowNuVxBE2A
	e5lhqJEaLy7R186XO8fmNy/Fzs+sJONigJWhvfmAgG7QqiowQZHoKjZMGV5FobSK2aQPKa
	hX1RkDduWqZfiu2/+gsnlD2oOBdZE5Pl9kkbroxFLWka0vbHCrBFFXsrF3fqqGtwFHMukQ
	phUEnHUfynFrHyXsIKZB9EliVxSRDaa4ANTlZ4MSVxzyrP9ndxLDeh7s+UJpzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723712022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maVLekNauL+jpDz+leGh246XtWlgDC9MP29oK4IiT7E=;
	b=n6crkEUp63LnOqn27icdijXc1Ze4PzkU1YWR1wP7QoBV/SWwTFvYEWoAbsWVDT2NjJX/9/
	NH49d78I62cbyLDw==
To: Tianyang Zhang <zhangtianyang@loongson.cn>, corbet@lwn.net,
 alexs@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
 jiaxun.yang@flygoat.com, gaoliang@loongson.cn, wangliupu@loongson.cn,
 lvjianmin@loongson.cn, yijun@loongson.cn, mhocko@suse.com,
 akpm@linux-foundation.org, dianders@chromium.org, maobibo@loongson.cn,
 xry111@xry111.site, zhaotianrui@loongson.cn, nathan@kernel.org,
 yangtiezhu@loongson.cn, zhoubinbin@loongson.cn
Cc: loongarch@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH Loongarch-avec support V9 1/2] irqchip/loongson-pch-msi:
 Switch to MSI parent domains
In-Reply-To: <6495631f-ec9c-c86a-39d2-1ada793b8098@loongson.cn>
References: <20240813085415.20035-1-zhangtianyang@loongson.cn>
 <875xs3petd.ffs@tglx> <6495631f-ec9c-c86a-39d2-1ada793b8098@loongson.cn>
Date: Thu, 15 Aug 2024 10:53:41 +0200
Message-ID: <8734n6np4a.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15 2024 at 09:13, Tianyang Zhang wrote:
> https://lore.kernel.org/all/20240813085427.20194-1-zhangtianyang@loongson=
.cn/
>
> =E5=9C=A8 2024/8/14 =E4=B8=8B=E5=8D=886:41, Thomas Gleixner =E5=86=99=E9=
=81=93:
>> On Tue, Aug 13 2024 at 16:54, Tianyang Zhang wrote:
>>
>> Where is patch 2/2 ?

Can you please thread your submissions properly and not send them
separately?

Thanks,

        tglx

