Return-Path: <linux-kernel+bounces-573849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08FA6DD19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B207716549B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E825FA14;
	Mon, 24 Mar 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOWhpTmC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066225F983;
	Mon, 24 Mar 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826887; cv=none; b=Lu82Q0Z24gaYY0CDO8AAlgYbrYdrRQl2VoU8XSePIp16AZoz9UK+xnNFCu3hIPZwxsU6wNGI5Lu3mCsG9RA/UYLgcBUTb5OO8H/Ua88ddOfDo1Ufbe7Eee+REH27NOJ+c1eD6Ch40zqN7Gcz/O3aoQLo4HoqxDgkFBcLIQ0L7Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826887; c=relaxed/simple;
	bh=WT/+BeD62A1OeYXY5vlaJt2n/KfbUJxJsXJx5/sO6H4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSGGcUUx0/mL/4FmEQZBkqTGieHs6YXkXYtip4ZREOmddq8/vysN0q2Q4NDgUVuYFoAI5SxuLY1T2e8dkXiWcF4lRkkUNYvEl6Weu2BEim9enZ0CaxzV1iQ4FDc8+ZOskIvwphkUM+R+iMJ/b8wXynsp3Am7nnujFgbUWkV/U7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOWhpTmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174D3C4CEE9;
	Mon, 24 Mar 2025 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826886;
	bh=WT/+BeD62A1OeYXY5vlaJt2n/KfbUJxJsXJx5/sO6H4=;
	h=From:To:Cc:Subject:Date:From;
	b=eOWhpTmCxrjrSKq2eD4MPD1gNH8YGXds87/ER1joRbizSyoWnaYDEBLtq6kdqj5i8
	 G/3Ygnq0XnGOzDFx34OFpch9t6sbUbpzC6w3IY+/BLMzG4cPtxnJBf1BmUwU8Krd4o
	 IxjBc0zxZIqNbkbatwnsBkMuJGPA2Bgeptsx+h1KNXnh0rUzwJO6QtkuAo/vJZmRDP
	 y8TFsjL1XGXOT8zKi1whnW4HOy29OfmtrQx1KhW7KIeW5/VQBuSIAE9ji5kNwKRwUw
	 zvAwt9ElXimgpGWIXMaJkvBpPRorMvt4aqrWMBmKvGZFTgiqh68g7fGvn3M3UoH9UH
	 OD/whdHcy9kTA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] tracing: Show last boot module symbols
Date: Mon, 24 Mar 2025 23:34:43 +0900
Message-ID:  <174282688292.356346.8368421078882769536.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is v6 of showing last boot module symbols. The previous series
is here[1]. This version is rebased on linux-trace/for-next,
protects module_delta by RCU, and remove one #ifdef by adding
a nop make_mod_delta() for CONFIG_MODULES=n.

[1] https://lore.kernel.org/all/174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com/

Thanks,


---

Masami Hiramatsu (Google) (1):
      tracing: Show last module text symbols in the stacktrace


 kernel/trace/trace.c        |  133 +++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |    8 +++
 kernel/trace/trace_output.c |    4 +
 3 files changed, 138 insertions(+), 7 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

