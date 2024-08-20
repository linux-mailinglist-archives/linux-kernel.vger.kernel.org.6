Return-Path: <linux-kernel+bounces-293709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB63958361
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883DC285A97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2C918D644;
	Tue, 20 Aug 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="FKy5zVJd"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A218C03E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147810; cv=none; b=cw0i/myvKwi4fzqSwazQGYWgdn2bh2k7O4nqVl2v0Jy5IMgJfD85DxBLl4pOjYt+R8Bvb1jtLUZOZK6jQ2I/D6SDcyYWp5MatX3F4h47cictbckKAFgneSz5ros7SptP973CiHmqaQI8HYRhmbcLo1kk84bxDRFEY9irgIlkedE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147810; c=relaxed/simple;
	bh=yEe4hNtUa92NleJbOQ7RAk5Rz1u6oUunOkqgIRXIvlg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aiEYeMujvi3Hxzqww/WUW2CVEtEtGTQxNyDE7cHhaZKJinNMqeJK2KDAXTjJ2GkV+aVCY/xcb78QG1WIXgGDxeUPPvdFm+7QtAgpPHxw/zI0tJqoYPMA05ULAI6GUBC1lPU4dVgQ2TySiH3xqXpJ5GHrQaLjPoCaZ4TzBPiSG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=FKy5zVJd; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724147804; x=1724752604; i=efault@gmx.de;
	bh=rYSWq7cvuvCTedTp5MD/U+jfkK6rmYWwk8Low9/0abo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FKy5zVJd9oy3BfXu0W/Tk/GXPJBL/d+7LRaVJUNBo4NAznt+Igw9aXWBal6lYbf4
	 4DeEEPsH2T6dVIHEfu4ZLXQoaMG46AygBS8EMmSeuKUFz6CvaWlB37WsNwsJLeq04
	 7QDdYIpIRk5+Mfp0K6ib8cksnCW6qc3Z3+fooXT7EisjoUtQnNaqmr3D1yFDCiAtn
	 joXSCGKmpA05FZ9kNGegAZBHpwLVLzfM7ospwQnCw3UUm51rqbZA2cuRgHJ2dpZql
	 4PuVuxsnhZIyjPdLvgeO/EzYzqCsj6ECw5PSC5IN0x3MS3NVgydmKTDEcHd4TUu1n
	 va4DkZJm6Cm3UltoUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.139]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1sj5h02Zy6-005BTk; Tue, 20
 Aug 2024 11:56:44 +0200
Message-ID: <f493df13cf739285beb01e8901b04a7473c353be.camel@gmx.de>
Subject: Re: regression: 9eac534db001 ("firmware/sysfb: Set
 firmware-framebuffer parent device") broke nomodeset boot?
From: Mike Galbraith <efault@gmx.de>
To: Thomas Zimmermann <tzimmermann@suse.de>, LKML
 <linux-kernel@vger.kernel.org>
Date: Tue, 20 Aug 2024 11:56:43 +0200
In-Reply-To: <81f2d0d9-386a-4535-af1a-e9fff18ead8e@suse.de>
References: <af56820e03d9a52a472ec914a17310d11f8d0227.camel@gmx.de>
	 <81f2d0d9-386a-4535-af1a-e9fff18ead8e@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FdPSs34ts/m+o0Gqc64CZCD2UIYkdsxUbwDQD5ghg9FWxObLRR9
 0PHXcPOsyKtIdlguYVnnp0CFk5JhvKRD9GWz6jqVMDpy7RZ8HEVecXRjHZdYcE+9Y/P/0lC
 tMXuYeoG7KZYDkVFChvZLPAppUKonRIedL14nItBc5Xtef385kvnSd7PXx/Pj3+stHFdNeV
 kL0/R7JavwWNtGgMFQIvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hwpH9f4Cu5Q=;p1I1x/wT355f+6Yw1fkkDpgQzLu
 2E5Sgo9263u4rCbXORc0wS0MnODdoSiT7qGZkmeDQfXnB43QxKMV+Fx0zYZdbJA2C0M5gQ0+W
 u/DPyV1GtHzKrKA21B2cw047MA95dnmaHFX7vU1/y0SRdnwUKcEqgZ51CYEDZYyQJgKee+gPj
 vH8uF3aId8Kd4shlQkXT8F1+DJvdY6OEwhmOKNQofuuVKrYmsNaxKaYXsWpSgYUhAsLyT7Le4
 knLAdh2yxPa3DysRwl0Zeqr6py9MB5meqVXdwxdken3iTT0cppDejWTJwwAcftYs99MTxkV92
 QMtaWLS0Db35tXFfRocFGeq6HSUeXj0LERby2GhTUbBWH+3iIQqqL1+iWt+5kzm2yrWSFSeXb
 vN12/2C1SfwijfpF/7BqN8dZ6UjvzpskSHvHliHHpdDzXjVAffrFergP1+FkqOCoE/f/nVjfh
 +7t+yKl6AMu3piMBR+jem0RxIVNNzPjvwM87IyKUKClz8BX7d8hU7Fi+L67X94HFccd8QFmMy
 nuIJSW7dRi9Qyr2aPx+7vQjVulSqSyhC0X1vfFy3UtWuWFfaHVCXz8lC3FG++bOMlYhmKJnuE
 9aB9pZmuHFa82HHMJ0GeEm6VaAkXWhkrNRWV8skGjYFP8ZYqo6RrMXcW/ae27nYN9mHo/fBUV
 lxNLg9e8p4oV30sufgZDRdKfw8CmZbD+W1AXvuIaR4d5a6N+VTT4CBGad1TyZKPDxr6nS7IuF
 pIgqf/bh590WoL0mVQV8TDgh4VoV4oV+EepiiL4Ey6lkstb9t8zUT/6UyTUf2W7AXeihYaigu
 +Mn1/v9c5HNapMmazZffqPKGV8RwVKsAeCBbrhq+Jb0xk=

On Tue, 2024-08-20 at 10:02 +0200, Thomas Zimmermann wrote:
>
> Please see
> =C2=A0=C2=A0 https://lists.x.org/archives/xorg-devel/2024-July/059269.ht=
ml
>
> or
> https://gitlab.freedesktop.org/xorg/xserver/-/merge_requests/1612/diffs?=
commit_id=3Da745f59bb193c7a87959fddade9b637278e5528e
>
> for the fix. We need to make Xorg's fbdev backend look at the correct
> values and everything works.

Ah, thanks..  I'll keep a bandaid handy meanwhile.

	-Mike


