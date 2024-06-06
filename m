Return-Path: <linux-kernel+bounces-204456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D248FEF6A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48980287ADC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E32199E9A;
	Thu,  6 Jun 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vl/CC76J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxgvhS5U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C9196434
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683914; cv=none; b=eC9zwxlIaZROlDcsMebQhhZ3pQep2+n5eebFyHmp/DgFcOGqOAlNqGlM9n+ArAcU4PDJCfhDa3clYc5f8o++VdKbJtfTb3J8nhd7du6pr6CjrZtn9E5N3z2iJCrb7cVjIyd+aibABHcA991si2CpVTgyBQpvZoLyWP83jolnB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683914; c=relaxed/simple;
	bh=55DOv+WemzOHgA1LKxXbk15qfaceo7b16a6UQvpzg70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxc+eOfFLkj6LUI16a9zV+VMgMVzy826I8+BmMXjhSjPXCdQfMNNC7+Dqv8BVtIb9hEewxVvaqdhTx30HXeyjFGTuzQwHZCkeUJo070adsOpyVbFfcX09HAoOdawcCnEQ05ZiyP+z0kp6sbqLQt3XSoRvl+E0BDEaDX02HrvlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vl/CC76J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxgvhS5U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717683911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbeeeM/qoQSiUICaXa6gooEnbgBLMQqpZYgf5h+mTsY=;
	b=vl/CC76JVyuHea++LLkkeFFPN+h0T08lOlpreAjgAuNSZj1ftiRWoeKUKXLjKvByggEEiF
	sd2rSI4gJg4DVn3v9YQvJGfF2CB9/mvTsZvYLx4c4TU/0EqBywk3gvQJVyrMhAxlKEsiCi
	71eOgXcmJVMsMFfWCg7sKdSq+87TF0q3rbgwEMi53fMaDMMFkTTGaUMDBG80A9JmU1RzxR
	/i/pbLAHJgNjFwdbbghCv7LzaCmrfS846prGvVyDj0yn44Jznr6dmXZt6UhwBGKNXqdtIo
	Kq7wBYgkJFgHlIDB2nuToEy0VRU2U05B/0BGzzTFcPgT8xs0TChPsKc727JQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717683911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbeeeM/qoQSiUICaXa6gooEnbgBLMQqpZYgf5h+mTsY=;
	b=lxgvhS5UoeLtFUJJBkq8ADcxbQuVzPCCMU2x2vpQ6mp5sR3vqhm2hHL1eyUT2F2a0FFf47
	5msiK/OBbW+WXOCQ==
To: gaosong <gaosong@loongson.cn>, linux-kernel@vger.kernel.org
Cc: chenhuacai@kernel.org, jiaxun.yang@flygoat.com, maobibo@loongson.cn
Subject: Re: [PATCH] irqchip/loongson-eiointc: Add extioi virt extension
 support
In-Reply-To: <d5efc13a-f719-bc77-1adb-feb73a8155b4@loongson.cn>
References: <20240605070229.2569875-1-gaosong@loongson.cn>
 <87a5jz47hc.ffs@tglx> <d5efc13a-f719-bc77-1adb-feb73a8155b4@loongson.cn>
Date: Thu, 06 Jun 2024 16:25:11 +0200
Message-ID: <871q5a2lo8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song!

On Thu, Jun 06 2024 at 20:58, gaosong wrote:
> =E5=9C=A8 2024/6/6 =E4=B8=8A=E5=8D=881:36, Thomas Gleixner =E5=86=99=E9=
=81=93:
>> On Wed, Jun 05 2024 at 15:02, Song Gao wrote:
>>>   	int index =3D eiointc_index(node);
>>> +	int cores =3D (cpu_has_hypervisor ? MAX_CORES_PER_EIO_NODE : CORES_PE=
R_EIO_NODE);
>> Sigh. Please use the documented ordering of variable declaration
>> ordering.
>
> Sorry, I didn't find the information in document [1].
>
> [1]: https://www.kernel.org/doc/html/next/process/coding-style.html

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#coding-s=
tyle-notes

Thanks,

        tglx

