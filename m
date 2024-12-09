Return-Path: <linux-kernel+bounces-437691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46429E9733
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD521883349
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A91A238E;
	Mon,  9 Dec 2024 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="eav4163b"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7D35978
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751090; cv=none; b=QJMpQJ1tZV4ZmrlFDmQVLpOXjNKSX8ztPNqOztr/+DB15FyGGoyp0+i29QJMTu0cQ7lL7PB0MzHKNQ8Gc61Xll0+dxGvb5j90u5o26evt+4acHn2W9GmZC2dIEdef+lnyEA+A1Bpo0kLq9Y7YfsxCA2xFlqu6JMUS9U+LTFb4MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751090; c=relaxed/simple;
	bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO/PlmDBy0oJNAaXD1IUBF2TTMFV2sVPV95la1z/4tR/A1PUzoYKD6WcZgnND1muaZ4Qo+F9rlojWNbdh466IkrGpf22AGQR2wOanzDH3iDjvDsU65xVdpVYbG3wqhyWWuVJixqcXUE3+8WxcCHbEIxqzEH+IuXWLx+RsA+kcbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=eav4163b; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so454299166b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733751085; x=1734355885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=eav4163bKLVCrPUzdJn2t6pP0npxxYcNFWQ7XABtjftU9OfbNpiJ7k4k2omG0DajVi
         v3vXyRwCsvblR8EyhnRHYJtIWVxageQiA3dTIp4R53NAqeNI/9ZU02OqCiw9ax31t5pM
         KkzOHe/gBvOVcUiAaViftb9Wbj9yuU4LpykbyKrveKQcsmxhZafVPgcg0Scs+ZxCNSeS
         Ski9zY/rTdN/SCBYG1Upoz9gb8jzL802cQmEGHH7jocRpIC2MR1FKufjXigVdovmb6EB
         gNScHhiCnQdKP/juqshHE74bwNpunczm2W4sjy6HRSJX/Ebv8OOBdog1NmxyYckRENfz
         u7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751085; x=1734355885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftTBkUoM2LcsGeAp9168BTi0yYIu6Ei50+DC8gomF3g=;
        b=gQNX5wGs85fiRgg67pDz1ETA9OBZh7qOTuDcia5+vIIPXbvESTZ5s2eh8zE7wZTqUq
         o4QhnOUDmTC1Tbc9PL4qIIM7o/gvSjXXc128ttPvebY3/ZjwbQcS4bcceyTag86AT61x
         ilrGxVvQzjSLcNzPze1+lqvYDIlSsc6MZgiDDh85QPJL1NqMQRxnQVvrMoGrf+evA7AF
         ybhmBXE7PE8oMzUEXAl65zYH6AcPjC1S6LL6CVGcVlr8HKQDilzu3pchUgntYSdx3cv5
         DXpiOekBGCfMjeFC8aePOiswVzgxvie6oTrIReUKf+UXS6GZf6nK7sTAYJ2z6GAk8uVj
         0kGA==
X-Forwarded-Encrypted: i=1; AJvYcCVQvlxsLN246cDFw7rpnRC6XUY8TSmZZsoGCH7TlupFagmJqoSpl3mM+PThh52dw7GsUFtRiGFnlVbt7Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuDkRlkzJ09NupJjVYlnqQwnpmkEnGIsO0Gc/SeBCm4QXXKenX
	apqi+kZpuREyI0Gg210DiGQJ8DXf674T+BkhhFN74JgD+KxXhmSkVdFEzYcGMFyyVGHXD2NO9i1
	VtsiZgewfeHzGeKCKkoO7ltJWczCYrAWNEYeAmQ==
X-Gm-Gg: ASbGnctEhfXcPlXMVC2WZr/11+co+oXkScH7Veh5fbEf0m5q9gcFgXRGUsPrE5fO/Ls
	v48yO5qjbNiUB7whYb4PkhGvQhR0jtsKPnB4NpLXtsjG+HVA3ZpixY4R27gBu
X-Google-Smtp-Source: AGHT+IEmztFz48a0t6/WSmXctJ2wrGWImd2oFKYKo2f4N5KU2N5Ux6YRxIOaj/ZsHQRzkCXMX15Wbqnx3MAscmomOG4=
X-Received: by 2002:a17:907:9518:b0:aa6:7662:c56e with SMTP id
 a640c23a62f3a-aa67662d783mr557411466b.55.1733751085028; Mon, 09 Dec 2024
 05:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=gcmkzwYSY4syqw@mail.gmail.com>
 <3990750.1732884087@warthog.procyon.org.uk> <CAKPOu+96b4nx3iHaH6Mkf2GyJ-dr0i5o=hfFVDs--gWkN7aiDQ@mail.gmail.com>
 <CAKPOu+9xvH4JfGqE=TSOpRry7zCRHx+51GtOHKbHTn9gHAU+VA@mail.gmail.com>
 <CAKPOu+_OamJ-0wsJB3GOYu5v76ZwFr+N2L92dYH6NLBzzhDfOQ@mail.gmail.com>
 <1995560.1733519609@warthog.procyon.org.uk> <CAKPOu+8a6EW_Ao65+aK-0ougWEzy_0yuwf3Dit89LuU8vEsJ2Q@mail.gmail.com>
 <CAKPOu+-h2B0mw0k_XiHJ1u69draDLTLqJhRmr3ksk2-ozzXiTg@mail.gmail.com> <2117977.1733750054@warthog.procyon.org.uk>
In-Reply-To: <2117977.1733750054@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 9 Dec 2024 14:31:14 +0100
Message-ID: <CAKPOu+-Bpds7-Ocb-tBMs1==YzVhhx01+FaiokiGR3A-W9t_gQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix ceph copy to cache on write-begin
To: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 2:14=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
> Could you try this?

No change, still hangs immediately on the first try.

