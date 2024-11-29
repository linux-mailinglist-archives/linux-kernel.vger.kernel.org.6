Return-Path: <linux-kernel+bounces-425178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC949DBE8A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611FD164E37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541D14B08E;
	Fri, 29 Nov 2024 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky32YVU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03C22EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732846108; cv=none; b=B0xa8hI7SWrONZdzJROf931uXb30+gL/zfa0jisGT8kFwfupSysJZ3wuu2c/osGc0CKuSkp64dnghWWjIqZqrbKU+IdjXL/6cYpOWmRLwcycKytoyA3gw7n1jsLBIZuSnEYw/bdrp5rOq1HjLgPX6WzBiEKueutBvHP7RcKa/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732846108; c=relaxed/simple;
	bh=8fF+cheTFU6nYMPJBKxNJuzNGwSy0DI3R416dYCU8bw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BvovCbtEzbeTt1lGYAvjQG6qjBxNwlHnMzYDAPXEZ8il5R5rPP18T7HdohXkxBQP7c5vk89347wQfb3YLlW64ByJo3o9Ul3HGhTerNQZlEtxNyCCIJVul92hJyeunnYHp5s0lEPwOvE4sjmUtvVH9ONeRoMv5yEwFTkjtI+ukb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky32YVU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F014EC4CECE;
	Fri, 29 Nov 2024 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732846106;
	bh=8fF+cheTFU6nYMPJBKxNJuzNGwSy0DI3R416dYCU8bw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ky32YVU1s70ACe73rZSE/9Kj4f1QNMooyB0d6xrXJdVoxiUAuasen28j2KPnulf9P
	 K/TeSZ796jsWq6leD+gqXoEtHsByN+d7KGRw+1R4rGicjtWNPNKoqwyNMbECwrs72a
	 2JWckVT3CoKq2UPtORO2BqiwK9lYjbDs2Bu6ualEwg0sKVjmeHLfjOnY4ebmOzekv7
	 zI5XbIvGcXY7g92VJxjTkZ7VxQfE7ZOqHnNvKwD5QrxDzRMn1dQYCWXd7F5gSoFwJD
	 S+TKqvlAVvwk58oL1L0oTPbkG525us2fFY3njH1bJ9uKpTopC/n+nFa4p8PT100JKS
	 /BESjxdC2HVPA==
Date: Fri, 29 Nov 2024 12:08:21 +1000
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Al Viro <viro@zeniv.linux.org.uk>
CC: linux-kernel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Eric W. Biederman" <ebiederm@xmission.com>, Nir Lichtman <nir@lichtman.org>,
 Tycho Andersen <tandersen@netflix.com>,
 Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
References: <202411210651.CD8B5A3B98@keescook> <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com> <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org> <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com> <202411271645.04C3508@keescook> <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com> <20241128020558.GF3387508@ZenIV> <CAHk-=whb+V5UC0kuJkBByeEkeRGyLhTupBvpF-z57Hvmn7kszA@mail.gmail.com>
Message-ID: <13223528-74FF-4B68-B0CF-25DCC995D0A0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 28, 2024 12:24:27 PM GMT+10:00, Linus Torvalds <torvalds@linux=
-foundation=2Eorg> wrote:
>But no, I do not accept changing well-documented behaviour of
>AT_EMPTY_PATH, much less the insanity of making "execveat()" have
>completely different semantics for AT_EMPTY_PATH than a plain openat=2E

Yeah, that was going to be the next question=2E ;) Okay, so, that last thi=
ng I can see here as an option is to add an exec-specific AT flag, and if t=
hat isn't workable I don't see a way to make this happen with execveat=2E

-Kees

--=20
Kees Cook

