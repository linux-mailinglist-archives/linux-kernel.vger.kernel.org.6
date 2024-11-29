Return-Path: <linux-kernel+bounces-425438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4112D9DC213
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F219A164623
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A0018A6AE;
	Fri, 29 Nov 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yiEsd9XE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B7155753
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732875875; cv=none; b=nTb5o3wTpK3uq1G58R5Mnz6CV+kgZ+TZYcjzVSZC2uDINoHxVezWEnj16EZTux0lISnfEbtz9sqq6ZwMlZGRIHXW/NrtnFXRHSJIQvQV+XreY+VAAWrSc/wlAVUSsrsbgE2CYjxGjCqVvXj6WDK7qR9RIact+JXYLUAlhqAVHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732875875; c=relaxed/simple;
	bh=txOFNysgG+9Kq7aIm3YxiWRgz8WOt2JRYyfojNokgVM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VtVm7nEg/SpqFuDGp1jKoGLuvqbHNZEFLVWKQGhXXGUmxflMUbmPH/mJRuAbNKPnvjRKCYmCITIlBwSIRzEeruPp9uGB/woxMBOsLfqV6c6+HgFct7NIQhNaYuaaq/TtGS7+MBB4kFA6jvpmjANjcxnsU8eEkjsSimfUjhX0pCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yiEsd9XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3375DC4CECF;
	Fri, 29 Nov 2024 10:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732875874;
	bh=txOFNysgG+9Kq7aIm3YxiWRgz8WOt2JRYyfojNokgVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yiEsd9XE/oZ2LZITBheq9IrnwU4qEZc10V/aVnRKd5Qgg3YZU2juLNRHaxp8FL4GH
	 0aSlQoNmR9aLwuBa+zJV0X+0aNsozgUkAo4NiFUc25Xzd8dUYwJAwQvfe4UytoxM8L
	 nrqBrO2Qe+rjJN/G4xgbXafO9TmFXbpoxAn3ufWs=
Date: Fri, 29 Nov 2024 02:24:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Shuah Khan
 <shuah@kernel.org>, Julian Orth <ju.orth@gmail.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-Id: <20241129022433.a6681752e56b96296a77be67@linux-foundation.org>
In-Reply-To: <0b1bec54-e45e-408a-a770-3d5bf2cde101@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
	<0b1bec54-e45e-408a-a770-3d5bf2cde101@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Nov 2024 10:03:51 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Andrew - This is a hotfix for 6.13, sorry forgot to tag the series as such :)

Jann's feedback didn't sound very ackish?

