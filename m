Return-Path: <linux-kernel+bounces-418759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508E49D655C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A7C161485
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 21:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBBD17B425;
	Fri, 22 Nov 2024 21:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nk/UoU8i"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2654F95
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732310254; cv=none; b=jI7HGNTokFmg+oyL74vb6OHDmcSS8B/UTXPJBQpeaY6EKk7FnIVCYAstWgPAiG6Y9fReaETdM1bUVYfSl5EnW1lR4SuLKzEkIKCyV962p8OFQoKycJaLmiUmKmH3mJ8SZa72XzR8ceAcEx4dXLqDEhHNIy0dLEmf8448sNdynrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732310254; c=relaxed/simple;
	bh=a9NTqI7JIeSOgcQv2ZuMLdHNczf+M3f2jIefOearBVA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=eZTnD8RMh40gAOOH/l3sSABXhmZCxKvM/SP8VcalQiCh1kEoLx3v7QE0Cip7cFH2SF4LkdEjSUpT0hwV+GyRmwI31Cpvb7pNOqSyGXouD7NaxEa4TGACMWH1gzg5cRnr4Gpb2qJYUCrPdAo0YNrS6EeCExUcFLfipfBRz+pb4PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=nk/UoU8i; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4AMLGcuS4011821
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 22 Nov 2024 13:16:39 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4AMLGcuS4011821
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024111601; t=1732310199;
	bh=a9NTqI7JIeSOgcQv2ZuMLdHNczf+M3f2jIefOearBVA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nk/UoU8iCYWXgaZADbTdHp49SjgEjClyifSkB/oaG0LIA562MZIeD24/e8lJAOhgT
	 oJuXmNCdPFowYDs7IZTXwVESf0aob0rzaF7+epDYu8e7hmKAxV7Hq+LTq4pDF0yDED
	 05gPcTYPABsgrr3NvrkH9t769YJ6eeF0lF3p54zeORF3R6pshd9EafkHwGIuFxHAO0
	 3SOw9Hu9YGTOMEpOJNYNFDD6IZmbW/InJhTeKjYOW4Lf0LWgENdxYhIaR2fwpF3XVl
	 bgGcp7sXFmBSkcUaHGx4rE8y71uFxZSdRtyoAk/p9lLcXZYIrSJyWsigVjdOSq+f+J
	 I3UHW83FoNZYg==
Date: Fri, 22 Nov 2024 13:16:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, brgerst@gmail.com,
        ebiederm@xmission.com
Subject: Re: [PATCH v3 1/1] x86/ia32: Leave NULL selector values 0~3 as is
User-Agent: K-9 Mail for Android
In-Reply-To: <029284c6-f103-46e0-9acd-9e9e816e7ffb@citrix.com>
References: <20241121175446.3481862-1-xin@zytor.com> <029284c6-f103-46e0-9acd-9e9e816e7ffb@citrix.com>
Message-ID: <3D641FED-D140-45AC-8829-9D057FEED3BD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

In this case you want to keep u16, though, because you are otherwise compar=
ing with the wrong value!

