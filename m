Return-Path: <linux-kernel+bounces-544013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D827EA4DC6A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9927189DF95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD61FFC55;
	Tue,  4 Mar 2025 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F932jnUs"
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674811C2BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087194; cv=none; b=Lx4ozRGn9JWkuSekQeYoRM3XM8JAlay995JHTPIni+Nz52sDzE2R02n/x7nUWQkgufuelPgBDCdgGbUgpXM2cfrUEDMw/TGzCdzpPOm4yjAH+SaoX/gI5eFagmKAHQJaPbuO3GQkeeeNSZK5O78YjOnHgXLdJEWgwgpyUne5IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087194; c=relaxed/simple;
	bh=qLs8U01UiazbgcoCHSR840yYQzt8WQHD9x/buwJe8Q8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=P/P0JCWxsoCVfCVnGMnZRCM9rbKTJGmMy6NC3I+vMdWwliJ8jywpuiUm9BNRsyASBc5MIhcw9gaV3B2CUK2haBqduTA2mmLlqRMfdK2o2iHbRYfQWX8mS/6mkjBKF3JQzdi1Mv3Xu7al1KgoodIWBKTeFzWfeiia1Al1V2rGK9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F932jnUs; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so4527755276.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 03:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741087192; x=1741691992; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PssJRo0tEpI7Oqgx6C3Ph8bPI9aawrbU07VnlOXuIlQ=;
        b=F932jnUs4+3Lmjl9CEzUICTfaGE4IqHTPYxHcshrKUpNiviJQLxq0ctVZbmhnWVN1I
         p+p4kjih2laBuh/HRCBr7T1numYV2nCbSC4WPkIU6yyomcuBYeHkh6XRXA3nxF2qBzV3
         5rOItag/uIeKd2lsB8oE3didvkP2VXWgQpAxdJmUMe7M/LGdJ4ERUzme4Qy6wqJBJP0O
         +6GBqsQCksNkPvcwMgI5P4isw9Rsucmfcwq1uPZN4Gm36CPfH5st0Rcc1r8OS2hcWb1C
         9qpuLiFXjYkb4f+EcXCb1I9QhiTD30YtNntTQkVe2uWPNhpirDNZFFo+WSxFZAQNDoYb
         W3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741087192; x=1741691992;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PssJRo0tEpI7Oqgx6C3Ph8bPI9aawrbU07VnlOXuIlQ=;
        b=LI/4Fz+XeNK9JYsliC6O0SlPBObminqpHkJ5GLm4GUOaz2ESqfqsOh6kOuVfS8Sujt
         ooCAJXkkaOi04W7iYho5W01feUvRiQsQEG15W/mq5c5y33M4UWyU0twRaF6Xi1EXP15d
         u7X3zRjcrYXCGn5oMvxjmHQ1qy4RXv7YjG0O3oSzn5yNMCXeNVAeeRUQUIBEKbLrAKvo
         2Ahjkz+EyLT2HCxoWxzkiO9YqgL5WPBsxZmhTL4Tb0JqX2bM1HxgmjobJ2Y9wwKoILiJ
         KFEFAaTZMtuVvNC3XLW74zs+fZ2aGsKRJdM4N4da6SfWzu8mDkctoHnvA9t/8kF+9Ow6
         PXlw==
X-Gm-Message-State: AOJu0YzeaJMkd6jNvFL24BfQjaDbRLrA84B+/O11xZnC2s88x6d4gRmz
	t4urZlf9kzhcPo/p3js+nB7ARoYtADwjHCiuSmb4txWg5ax6H7gC656CfiG1xMMHwzedVkc68JW
	dNJI9pexWB6GV/O0bbLF3lgnuAoasVTsn7ig9IQ==
X-Gm-Gg: ASbGncumqAwmaZaMdeLJhBUqIbGMON3t3BuvONdlGp5HlDrIkcyXLpblcpxK9IIjTdH
	srq6piMuunqR3HlxNoGI8qixhnhoJMPWdKVD97YhLeLwNG7lsh7m5kYI/X/HE+i81LyIhrG1ISq
	rIvaib6G+GiO/LKEEeZiFCVBXTns8cJJAc2CRr+R46FvuCToQGL0+p2FhsEH3X
X-Google-Smtp-Source: AGHT+IETIZd7PtjELToMPKLqijrfHbDrNDgzULHSOpu4v/yBIdPH+nAeQt8jYVoKnq3kVOkmYc1tPDgFICDxwKtROPg=
X-Received: by 2002:a05:6902:cc5:b0:e5d:ae04:1e33 with SMTP id
 3f1490d57ef6-e60b2e861famr21636139276.5.1741087192273; Tue, 04 Mar 2025
 03:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Amit <amitchoudhary0523@gmail.com>
Date: Tue, 4 Mar 2025 16:49:40 +0530
X-Gm-Features: AQ5f1JqYjy_oo1vv-JLTtXOrbtUi9JePQitQk-1V7QmWcnNE9y4zPYmk48Bm_ns
Message-ID: <CAFf+5zgB1UKyw8My54Rh7juFi1oAJ3xcu1-OhZ6Bc--ikwDjbA@mail.gmail.com>
Subject: Simple but sufficient .vimrc settings.
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Simple but sufficient .vimrc settings.


set hlsearch
set ts=4
set expandtab
set shiftwidth=4

set autoindent
set smartindent

syntax on

set formatoptions+=r

set splitbelow
set splitright

set colorcolumn=81
highlight ColorColumn ctermbg=black ctermfg=white

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") |
exe "normal! g'\"" | endif
endif

