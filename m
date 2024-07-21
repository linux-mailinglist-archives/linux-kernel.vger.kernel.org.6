Return-Path: <linux-kernel+bounces-258084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38286938345
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7028160B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 02:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3711FAA;
	Sun, 21 Jul 2024 02:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZs4/TEb"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B844A28
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721529469; cv=none; b=pCHnAB1ar6KRz2T9oPb9fJ0ih/hwa2HidwbcKmYaxGqCa0X7RDnQMADQfHPS9yMWruuCzV2GwyiDrrVE2w/TMiKfRvtqCCAVh7DkJHS+qDVLImyGi12f2ZZgzuZ/UED0j04anE62ZvzzHUbhnjyra4QxlJOejPa4FMydFKGMVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721529469; c=relaxed/simple;
	bh=Hlahyfg1sNue9T1oK7kBAGUyc8e/VFHhPVoCM9ReGRQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a2DZD7f2gW9RBDysa/a7a15Vc/1RucmFWOJcm11j2S82AYUSY4zHCYhssvqrGEposRxq3dzajN5xKO62TrLHm/UUtXsUe2XpGZazLh9AbCi9Jbv29LcO8NiAV8P8ecQ6/vDTUVMD/K2NXulRZ+oF0sHt/Fii+Iuuz/DZaaQoM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZs4/TEb; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-398b599593eso217735ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 19:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721529467; x=1722134267; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ+1g2auneEOCQAqQ9/NtAVV5iS3it7JtGVNLCLxuxw=;
        b=CZs4/TEboXXD587daIWkSkDavX+EOTuAx1p6RjtAvNL1afkWimXvXDppTUYr/DXwvA
         t/VAqErtJXCUiQArH3hDMbL2G+HHKEj4qdkT/xIvAUxoauXCn3FLT/91PAKJBAYpxtZe
         aAG7JuW5fhvEfi43mRov0L0cx3TMdmQIZIuAqTF6Nd99NzlDD8/FVQyO/G64YOGulu//
         ChWuzzlXV5w+dl84a8dYrlkiKDJcuCgu2zGBNHzHz5FXXGS9QLkrBixellgf+eac3Q9G
         WkwqtWkNjwoYlA9B9IrknhDmKo+8Ud68MJ+IauHrKX6+VgulAsLxH0PQtXlstsUVGswT
         z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721529467; x=1722134267;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZ+1g2auneEOCQAqQ9/NtAVV5iS3it7JtGVNLCLxuxw=;
        b=o9MUZz0IchMT74b6n7k3VYm4FbJqoMPjQv/I1RkOxiTe2mhH9CQl2bzQW5VpX8iAu3
         d7HrYmFuI50Dxp4BC9wFmPgLNWznMg26t9bKK+7IRyW6pa1s7aCEbo3phyPlqXEmlRzr
         JjnexlK2kD7KiT5wpUg42OPUs8WCeoCPMnI7MOsoGlWTm6Wr53HDha7wzDDTSNDEFG5e
         EgRBmOwbyC9d4eq+z4rXBzzjVJDgdlyLUStbJyXP5GO0roAwSel+RmonKPaWhH4oqIXM
         EcwDf3Q0uzduAh+OkUnAyt0DVBueFLT1/dXSmKeJkd0Jmc5C/5+SQkivaIUh2qYjqo7S
         cWpw==
X-Forwarded-Encrypted: i=1; AJvYcCV1CuKwCKxqFjBZ9jpSwh3QEIdxPSBgd3XaF9CVHX3ZVDiYHdFKQwDdS0xEMuXADhUingH71v8j0Xu+vvaheXGDQgNODdHe+g3lwqmn
X-Gm-Message-State: AOJu0YzoR7oyYtFrbW0Zgh17QwURtcBxoyWHYQarGSYDnIrLgrpa0eY7
	L8UBeG0dlw5ixlpbKE37JT3utkMT2vjjay05B88TLOLTIkJMTXEq5nD4Z4dQ3Q==
X-Google-Smtp-Source: AGHT+IESi9bh59N1PdJby2XO90Zi2ekjLcdSNwZ/Otr839kvKr/0qJTNsG1H5f8fJxZHfE3H6oVZ4g==
X-Received: by 2002:a05:6e02:1cad:b0:375:aec4:eaa8 with SMTP id e9e14a558f8ab-3993470816dmr1577235ab.8.1721529467292;
        Sat, 20 Jul 2024 19:37:47 -0700 (PDT)
Received: from [2620:0:1008:15:d155:1bfe:11e4:98f4] ([2620:0:1008:15:d155:1bfe:11e4:98f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf80a8870sm4243059a91.50.2024.07.20.19.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:37:46 -0700 (PDT)
Date: Sat, 20 Jul 2024 19:37:45 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    Joel Fernandes <joel@joelfernandes.org>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Christoph Lameter <cl@linux.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] mm, slab: always maintain per-node slab and
 object count
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
Message-ID: <8e2447d1-c0ae-1d25-2447-10bde334a808@google.com>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz> <20240715-b4-slab-kfree_rcu-destroy-v1-2-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Vlastimil Babka wrote:

> Currently SLUB counts per-node slabs and total objects only with
> CONFIG_SLUB_DEBUG, in order to minimize overhead. However, the detection
> in __kmem_cache_shutdown() whether there are no outstanding object
> relies on the per-node slab count (node_nr_slabs()) so it may be
> unreliable without CONFIG_SLUB_DEBUG. Thus we might be failing to warn
> about such situations, and instead destroy a cache while leaving its
> slab(s) around (due to a buggy slab user creating such a scenario, not
> in normal operation).
> 
> We will also need node_nr_slabs() to be reliable in the following work
> to gracefully handle kmem_cache_destroy() with kfree_rcu() objects in
> flight. Thus make the counting of per-node slabs and objects
> unconditional.
> 
> Note that CONFIG_SLUB_DEBUG is the default anyway, and the counting is
> done only when allocating or freeing a slab page, so even in
> !CONFIG_SLUB_DEBUG configs the overhead should be negligible.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

