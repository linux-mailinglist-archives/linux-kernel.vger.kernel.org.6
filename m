Return-Path: <linux-kernel+bounces-202698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F618FCFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCDD1F21273
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDEB18FDDA;
	Wed,  5 Jun 2024 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b="PQpXLZD3"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23FE19D8BA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717594225; cv=none; b=Xd9UWfSIjALKqjrQkG+zr5doHcppxQ4AZspoiUsiYPyxvrZPP2TfAElogKGRuaHlfqLoEp9uaZCxjHJ2jJ7AIZZfDSWmo0y7jizcJew/ioEOKQqeTVBmt0M7k5AYM2r7BtF/DVLKXu+ZB0zzOEdcOvqBy/4GvjlpWIGK7ekuXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717594225; c=relaxed/simple;
	bh=xi44l7csISapk7givPKiLbYKNzCG8P8FeIJiNhOFDwI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=UUbGIbhQ/+5wSoQMWhDB0YZKo/41/QqDufxjC0uE6WMigsbm0sOWXqNz+X6hz7cZgzTPZAvUgh79GwljmoCzlkCgdWTM19AcIQr1s2Nvfl5akNaTgxNVMaKUPNDiCEGni6KpZ64FmcqlBP3KY6FE4P5Y0WAlvS4hnY8eSEGsY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=aros@gmx.com header.b=PQpXLZD3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717594176; x=1718198976; i=aros@gmx.com;
	bh=xi44l7csISapk7givPKiLbYKNzCG8P8FeIJiNhOFDwI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PQpXLZD3mpJKJ5+Tv7f/xVSg5HRMNbkiQsw05uXTgAi+cCgpTSukHaqudBGt0ZoJ
	 mIUcZ9Tl6b99fdCJ5MhZcXKCraijhKxILYqbGPiGolIFDeB5IjlEum75sobzr7rPh
	 /ANgDGZPnR0izJ8BxEjuHMkTLEWk/AkyJFeKe8NvXNlJKDLfqYpgJZgvTHCsh5idH
	 nYa0ExRolFRWvdbTULac3CLFExgDYO9V6XJwkfyWEnpAi+z568D3DkVuaC5y6QeMM
	 +kFgTGD12uNOSvP534dCW/cPb7MURVJRLC/2krwPSMUsPYGHzPxDGORAw7zCM22I9
	 K0DmBzghlNYL1xz+XQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.69.110.22] ([89.149.39.69]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MfpSb-1sv4L82aL3-00es1e; Wed, 05
 Jun 2024 15:29:35 +0200
Message-ID: <9cc1e629-3b86-46aa-9d7c-f38108d7520f@gmx.com>
Date: Wed, 5 Jun 2024 13:29:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Artem S. Tashkinov" <aros@gmx.com>
Subject: PC speaker doesn't work under Linux, works in GRUB/EFI
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Takashi Iwai <tiwai@suse.de>,
 Stas Sergeev <stsp@users.sourceforge.net>,
 Vsevolod Volkov <home+kernel@vvv.kiev.ua>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J9n8XTg0o1PQLDzNfAjSk7RCK3kjpUAbH/uyatxCxtAXrhMk083
 CKA7dGPKoZEDZSj6m40+M4qY+2KvbTn4vUCoKmeZBimpRavDqNaxLw3by5NRD+lqUYBE1c/
 9ttmgstVKmK1SmayI/Oo4b3uhN1huSJUhrPqCZrnCzizo4WOzayNeTfvucx6kfKjFquMcMp
 0pZA0TBz3HdKwfYzyD7KA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JZjBZVKGDns=;KYTTAhqfmZrEk1DLpwZApdu7gzy
 3mVNRpNSQ6VX+i3Xc1XT0HWR2KXOnG1h8I2ytGTWZH1X3NH7FCHzKZCNRvqTLLd9ezZeD9FPA
 pAwK2s4BTASs6XBGDXBFRmRyLIJCh7TWe4G7XY/xNLgI4M7Dp05WiorRRamrVZpZ02GKqX8IU
 WinsqzhXyCBtBBXu3+Qnl+gcrOcwBsCs78UPg3qXejD6ifeE2Xj0azVdPR8cxo4BJkn+2TfRf
 4opIetNjZNPkrUjtoMoyJJQfRe1rDeAHLZnSALln+WiBEzL6UE/4inDdasRcCoUaqanec6UPa
 aQ2JKDleqzaMA8MO9o5SlKHHOae1OtNKvqVJsWmIblSaaNNAfOMF1oOswmOODs+gw7kAkVoWr
 2PK3WYv+NhYYwkytSx/ii2PTnPIKYQD9MbVQhiwJ1S9WbpKZVSS5dl+1f9EEq8tJP4KfN1MIM
 N7GVTGTs/3HqYuthAHnCD9zDH/3e3a+gZVagIY/MPxMOuEATftl5kaqy/j9F16uTHAbzlFWtJ
 YM0aJS6P3+qdFK7WqxbtZpwSDnC2mTyshnvaPvEZ4+aMA27XVLOugSVzLZ0bSuzcZ0tO1DNtK
 UQNQD5H1Q1j/SVCij9QhIWWNw13XNkpeLE3IJTlvwh9W/zf35H1eOSStK9cr14FF6/SDWTCM+
 hIqCpJzttH6Poz8vaPZCqHroQkzmOnIiV4uOiLuwFtzB9JFKrX0VmFY8gGSRf4GK/p+Zv980z
 ZHvlJjID49x7FA3Ze2e1CpS4BNM2FN/5odf8s0u0VuwCeGz+Z13G9ZFdlwylV31RUsAYb48Hv
 p4dm5uua4SfP8AcBHycpmUu8jXUvRB0j90PHjjoX6wHdw=

Hello,

There's a bug filed in the kernel bugzilla where Vsevolod is unable to
figure out why he cannot make his PC speaker work under Linux:

https://bugzilla.kernel.org/show_bug.cgi?id=3D218918

Strangely, it works just fine as an EFI module and a GRUB module.

What are the ways to debug the issue?

Best regards,
Artem

