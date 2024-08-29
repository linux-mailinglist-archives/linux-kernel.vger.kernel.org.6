Return-Path: <linux-kernel+bounces-306172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB23963A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EBF01F2136C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C1A157485;
	Thu, 29 Aug 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="epT9/G+r";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jytuvKZl"
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54314AD2B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911217; cv=none; b=pKvn1GfxQZTf4pic8xi4vARu4WKou0TyBNO36QMZ36ljbcgqTXJ7jfpFUWQ69mRDRduiOKM2vjuqf93KvLpjzOJunydtzh0JOonhEectLtd+zzhGX60NAxOy06T2nlI0VngD0xai//z0vQjq+WvZa6fw9ClCyVUfKba8SoKik58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911217; c=relaxed/simple;
	bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8f68XwUfq4ZaXZ62Pdl0ahvne2IAqgs/K8zifnsJFNqVHiPayajF4Czix0l86TDedvRkoM5v18RgzMpZ7p2cbt76nnIq0OI0yEjrayw6gPFGTdi1iRp6vCQSacwKYrijDRCzgf+LocHJPlkS6qEtlK9mcc8IXPAWJnZFx+TPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=epT9/G+r; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jytuvKZl; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724911215; x=1756447215;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
  b=epT9/G+rMJ8mREb+i27CPEuLL7Y6aIdvae5/7WCVcLwrekMLjI8jrJ+c
   U5d3Ue0WZEgw+pn4X/NRXAk2SSmeWBVEuzrxe9Qk0LQXJA9UMsQUVDUSZ
   jErpawWSzBf3eqVEeaLktIEwylrfhUbfOhPAySOxN9cv7SSrFRuR11jPX
   JNJW9BOuka5CK5HmgzSLscJIM9sLztBGkDwousHPzIyaYdgvx8FdaFcXT
   WGg8R7lObiTsmipae6eU60VByJ7zkWyxSYtUx29xsTXRDqKtBGcndsP5K
   0K9V3277ws24hpogPnmL9JwTGE1yNlOOCLwV1JXO3LZYkFIrgzHbZzrxm
   w==;
X-CSE-ConnectionGUID: 68M9jnEMQR6+I6wSbF+hfw==
X-CSE-MsgGUID: WWKWjqRCR8+KkR1r+CMMew==
Received: from mail-oo1-f69.google.com ([209.85.161.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 23:00:11 -0700
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5d5ffdc9ed9so429642eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724911211; x=1725516011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=jytuvKZlUOMeiYJnv1EfA2q7BIvZIREcrF8X3yTebJ5cmI00Ln9uJHGKQp2uWoHBRX
         /6q78ByY6R/V7YF8dsTuGK6ZhoC/SswRAl1h0EHKe4rU4BarERXBbxTEp0OuijXMBJHh
         ru91xnuNBrh34OnOhb1XXQJA1RQFW4XEIgRcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911211; x=1725516011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5+BxaXWvRBxDUcjcZvL61zh83/XIf0pWGMRioPHBrM=;
        b=NHlm6wyX6oiiICirI2809o+UXxTPMJnd8DBLphtM55TT80GnhtD6UqHj0BkAL3BYkO
         iriZSrZ3IPd9YqX8K15GlNWH4wUeydyu8DNlTJO53/F8KNDO+An7Kl1QTZ9+LxPKZA8J
         y2HBbQf3+waKbb7QWVq8obMf1nBMeSJAshvlJmxN6/dwKpCtHuUWfyYkeB6KMN9v6Hoh
         GC5LDOxjejZC37MKmyu1xPbpWtGhFsEjLAmzUVGWkKxBK3YNoXiMpLifPNgOoDnKix5z
         ajFIUgtz85DdrVGjqYLl+psFr8oo2dDzrV/PbuKQhN3Pr6t7wCG8nytxJ2EQfWVrWzNU
         YVsA==
X-Forwarded-Encrypted: i=1; AJvYcCWhLvqs2cJN8Lz+MxbacavQOidkZoXKP6YlNxkf0FmGsm7JqHy79q6MzeT5UtcY5veAv0HKL4acOaL4eMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaCmjYBszyUDjf7uf798CvANdM8X+9s8FnPeuQrdtdYgsKQuu
	0xG+5k2JkKRNeZnW7VjbRJhgyoyFHI/uGd1najJbzAMh5YiP8+kRCx5yIB8gwS8S12YJ2H9d8tb
	Xvw6kMjJS/ZOk77cRShpfK63lEBMqasROV9VnEtTcw8Y0rW+LWOHTSf/NTY7N81goJUm6kUfcUr
	qeZNQzuCEjaF92cjIN6mrAbdzw/PuBrirI6MemRw==
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5df980cf733mr2263967eaf.7.1724911211517;
        Wed, 28 Aug 2024 23:00:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5thjR14Ks+6judAwL4nDPvcXZjzFPCcbYGPrB7DoyTxw6g4i4UpkLaTzBuGzQKTfzqhlcGKfYt1vxkUxvhM0=
X-Received: by 2002:a05:6820:2295:b0:5dc:a733:d98a with SMTP id
 006d021491bc7-5df980cf733mr2263936eaf.7.1724911211146; Wed, 28 Aug 2024
 23:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
 <202408281812.3F765DF@keescook> <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
 <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
In-Reply-To: <BA3EA925-5E5E-4791-B820-83A238A2E458@kernel.org>
From: Yu Hao <yhao016@ucr.edu>
Date: Wed, 28 Aug 2024 23:00:01 -0700
Message-ID: <CA+UBctBGbAc5rDV97DaJGJopqTKkeuC8hHiMrN6irt84r0NoRw@mail.gmail.com>
Subject: Re: BUG: WARNING in retire_sysctl_set
To: Kees Cook <kees@kernel.org>
Cc: Xingyu Li <xli399@ucr.edu>, mcgrof@kernel.org, j.granados@samsung.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de, 
	frederic@kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:33=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> That's excellent that you've developed better templates! Can you submit t=
hese to syzkaller upstream? Then the automated fuzzing CI dashboard will be=
nefit (and save you the work of running and reporting the new finds).
Yes, we are also working on this.
And it also takes some time to figure out the differences in the
syscall descriptions and to satisfy syzkaller's style requirements.
So we are still working on the patch of syscall descriptions for Syzkaller.

Once again, we apologize for our mistakes of some helpless report
emails and thank you for your reminder and understanding.

