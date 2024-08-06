Return-Path: <linux-kernel+bounces-276695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2359949723
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5705E1F2227E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89197404B;
	Tue,  6 Aug 2024 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNPAt4bW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E558846444;
	Tue,  6 Aug 2024 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966782; cv=none; b=gEYqtVodXp8YwV7uT9DpcWn7W0eA5yh7lPiQo2KtEbWgW/z8dGYxETmIu1TCae9phdVKNoJjoB+bCEYPrWf5jq5JiKDTyakOMNKd6p77UjVqenGXFjp7+f4FtdmudivnliIIWmqCyUlHLwYF8JNkUPpZ6fsQeZjf9wk84lFJBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966782; c=relaxed/simple;
	bh=gmSIZC5KYnAD/TofwZBazRgPdFQqtGfwN+cwMI7Pk7M=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=p/ucJxvDKxfKj4fuxKGNDXtOFgDE+b+6qJJEa/i19EfeJH5eDiXn+kP8cQ5nTDCFKEaQfUv+1r7Wbq6sPAa0ctBH5OKlH6016EWllOyRGB3vz4ZvBciX+MCjymc1QWF9pHJzdK9AaUWdtxcKqod937ZhVkNtcB9AkD7KwBAwgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNPAt4bW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A164CC4AF0C;
	Tue,  6 Aug 2024 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722966781;
	bh=gmSIZC5KYnAD/TofwZBazRgPdFQqtGfwN+cwMI7Pk7M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jNPAt4bWNn2THMKNzTmhaep/zvemj8tjoRTcpG0kUiX89AphtZNTHPjgGqKNcD6uP
	 8nOxW0uxWPDwvcjWKFtTNmQNGLWnyK/H+FAa/V1yHzsTZN7yvyLdj0xXQlB2zteI2i
	 HyhayWT/DP80RX+Kz+NfniurJi5aRQxZOhGOLBmQTheM8MQNOgdxuVMDreR5TeUV0n
	 DaGwyZ/NmjVm9GukeWjpWWn2pYBMisEcVveG1J6bMBH0nE2/YVPR4kKUswLM6NwmwY
	 joW51YB+ri7ah+JoBheoCeppjB1FJXE3/0D/ciPuisBTrksxWBOjacN/12b8YSJgD4
	 QuWY/2gw64Y8Q==
Message-ID: <cca491b4b4f5716e634f7c0ce0c574af.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240806073832.13568-1-zhangqing@rock-chips.com>
References: <20240806073832.13568-1-zhangqing@rock-chips.com>
Subject: Re: [PATCH v1] clk: gate: export clk_gate_endisable
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, sugar.zhang@rock-chips.com
To: heiko@sntech.de, kever.yang@rock-chips.com, mturquette@baylibre.com, zhangqing@rock-chips.com
Date: Tue, 06 Aug 2024 10:52:59 -0700
User-Agent: alot/0.10

Quoting Elaine Zhang (2024-08-06 00:38:32)
> make clk_gate_endisable not static, export API for other use.

What other use?

