Return-Path: <linux-kernel+bounces-568601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFAA6982D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D828B8A7BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D15210F45;
	Wed, 19 Mar 2025 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFicFEtP"
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EE212B02
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742409481; cv=none; b=cfg/lPCGtfYUeN6N4tLULBQ6V+TCU28d8LKsN5Rx83tIcgh5Pu6wP5UdwEHdSmZSKyboFI9E/8NXk+yAMi9rMMkPsT90s5L5PwbjFuC5onUg3JfzCF2m6JA21Q7zSKqcHSiXkahGXajRjs6x/zNyHgHqCg5GeVhk+QXKSIm/vjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742409481; c=relaxed/simple;
	bh=1u54O193vNJ9UJyCPmT1aouN0YpCt/ylitFLEE8Ne8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rk9YQy+lQLv9tSGRbY9xXxsCflHO3gHI4bpdciOAqALUPIgbT5U2Mx+uQVKmTf5cdAC3agH1o7cqmwCPz+TiNT8VgKIOFUIgQm7qVaXZUnRmX7AEhxUbitg5IMPYsjV1X2Xmfn1AWwPpxt8YO4C3aaaw6Jove+osG+OUSPaQnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFicFEtP; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2451f5cc8so5374908fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742409479; x=1743014279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsvBxlf2VOaZb8vxBRnigpz+ulSEZ9VYrnq1SuZdcic=;
        b=CFicFEtPCa7KztCmw1QIrES4AYbG3G3aODJ113DJ5LufSNaqaOnqZKzfjAm6VwWjVP
         aA1Yp6WPPo9Xfsp4GfN6KtmeKcJY0sETUgVV2x5XaX0TIk5zkrMqfLynDuxB3P1C2GE1
         14AXd4pGAs4a+es7uWMVdTvpvRASUFeH9TAWiYiJPOhcvZp6+O3B3/XMIZJrQe+UTAWw
         tmoE/eprP6Vi82OGxv4NwgjrfQ/2rzh3W38b9QLb7IBoI11/K6W3ydF9YZ4L+7Fa09zI
         Sy00EYHbk5GYB9cITHC0UeeYbxcwd9cwfm1x972uva94m0qqUWgsKzU5XyjisXEB+Wk4
         0P6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742409479; x=1743014279;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zsvBxlf2VOaZb8vxBRnigpz+ulSEZ9VYrnq1SuZdcic=;
        b=clHPuQW0kn9josmFaWvgR8AGNpMMw6dv+NkOIUdNVOD9bPxVWm3cCYsroDJQf8Qvhh
         db2C98ovU0UfpHypzUEzqwbAuAkQG5VHwN6CxjZwFSqOsVmmo9A8/JYS04qPOihjIXwT
         GlljIyeBXiR3XupPsgKi6PfMpU+egB1AR1dZjifJHu+EEare+DyoQshWWSGwmh5G+qTi
         Rrn429NCJQrm3d2I6CzQq43j9OGGFaKic0BH/IqZUN3B7nlS6CXto97z1pgZCDsMbbzb
         rRLagwAZc0yhM+/MLlWPnF5gIAwiSgC4w98JFObxcedfJrt+uljsQhq2eD9I34zQlgvV
         VMbw==
X-Forwarded-Encrypted: i=1; AJvYcCXghcN6VRO1apfHqhsEHuJ7oJdNoCRsOvSbggH7/UfPwy2rtOj9s+e3cutw54HwqrWY0hIe3yeIsXdfL2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3Lp62aDRNmqAwWR3vLU7+5midbz7BEUh1v1qcak+OBjCNSVx
	dq6v15DbVWcl266JAc/TPLwxeoXxbjQxCagThW2i92iRS8Ul1RKxW0ZzuVViij/Wd2hgkt4Daw=
	=
X-Google-Smtp-Source: AGHT+IEBFA4Sa9YRWk85bQR5JAziUVGfY3Rr0Wgmbdq2OL7Uy5LWKzyqkOQ+Gg3mIXPA8ssbkLAA0pQ5ug==
X-Received: from oacpy22.prod.google.com ([2002:a05:6871:e416:b0:2bc:6860:2684])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:8984:b0:2bc:8c86:ea31
 with SMTP id 586e51a60fabf-2c762fc74d6mr174282fac.20.1742409479208; Wed, 19
 Mar 2025 11:37:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:37:56 +0000
In-Reply-To: <ifqn5txrr25ffky7lxtnjtb4b2gekq5jy4fmbiwtwfvofb4wgw@py7v7xpzaqxa>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ifqn5txrr25ffky7lxtnjtb4b2gekq5jy4fmbiwtwfvofb4wgw@py7v7xpzaqxa>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250319183757.404779-1-wnliu@google.com>
Subject: Re: [PATCH 1/2] arm64: Implement arch_stack_walk_reliable
From: Weinan Liu <wnliu@google.com>
To: jpoimboe@kernel.org
Cc: indu.bhagat@oracle.com, irogers@google.com, joe.lawrence@redhat.com, 
	kernel-team@meta.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org, 
	live-patching@vger.kernel.org, mark.rutland@arm.com, peterz@infradead.org, 
	puranjay@kernel.org, roman.gushchin@linux.dev, rostedt@goodmis.org, 
	song@kernel.org, will@kernel.org, wnliu@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:39=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Tue, Mar 18, 2025 at 08:58:52PM -0700, Song Liu wrote:
> > On a closer look, I think we also need some logic in unwind_find_stack(=
)
> > so that we can see when the unwinder hits the exception boundary. For
> > this reason, we may still need unwind_state.unreliable. I will look int=
o
> > fixing this and send v2.
>
> Isn't that what FRAME_META_TYPE_PT_REGS is for?
>
> Maybe it can just tell kunwind_stack_walk() to set a bit in
> kunwind_state which tells kunwind_next_frame_record_meta() to quit the
> unwind early for the FRAME_META_TYPE_PT_REGS case. =C2=A0That also has th=
e
> benefit of stopping the unwind as soon as the exception is encounterd.
>

After reviewing the code flow, it seems like we should treat all -EINVALID
cases or `FRAME_META_TYPE_PT_REGS` cases as unreliable unwinds.

Would a simplification like the one below work?
Or we can return a special value for success cases in kunwind_next_regs_pc(=
)=20

```
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.=
c
index 69d0567a0c38..0eb69fa6161a 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -296,7 +296,8 @@ do_kunwind(struct kunwind_state *state, kunwind_consume=
_fn consume_state,
 		if (!consume_state(state, cookie))
 			break;
 		ret =3D kunwind_next(state);
-		if (ret < 0)
+		if (ret < 0 || state->source =3D=3D KUNWIND_SOURCE_REGS_PC)
+			state->common.unreliable =3D true;
 			break;
 	}
 }
```

--
Weinan

