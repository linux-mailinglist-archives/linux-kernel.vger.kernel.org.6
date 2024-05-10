Return-Path: <linux-kernel+bounces-175659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC838C2344
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F9A28195E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED0B16EC18;
	Fri, 10 May 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JpYLSKGO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7C16DEAA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340240; cv=none; b=nqTiBk/0noZ1w85Ob8wgGsGJvmV3jeqYtUryYgnfrpyiOM4P+GMijagvrj0LjeAH1yIgObbLbIOtZwet9FsXBywPM8s3yxmcbM9Rdn7NlSKB7em/SvFnqYQZttQIwSpQS5binyObmqBRSrRfXcBRnUDbZR/McXBeI1RbLt7030U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340240; c=relaxed/simple;
	bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHz3rdNs/bEitY+UAq9TGRra17R3oe5F7hP+E+5PoSdYDq3cV9TP9liGi2gTP8w/5LTtbOoDFLjji23gD5gfNPPjDqSgQsW96tTaUzoZp3BV0yXXJ7s8QHW1gyZKhU+8wLIRw66eHvbvk5iF5tgPW3J6weGO8JXKZ1XrsoDqi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JpYLSKGO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c448b44aso490633866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715340237; x=1715945037; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=JpYLSKGOBfaIc5A8kOsi5/Dp2+/FW5QcD3PSDQjxzFhPoThcC9BFnBTZ6bjdLPn1y2
         H3Ciyfq/DoepN2m57HmuLeQcub49JESXoeDmgeJbyvwVncXszisdoYaiKihDJhidJ0fS
         guBqjTh2IcbqsTVlhlUJUWjpelIrxQkrhmoR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715340237; x=1715945037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47x/4Pk6TGycDhdZnlbzTMHVd0iRYhoMxpqaHz5aors=;
        b=vDmUfn3sp5pU7GSS2AFu4wJdPqXLCq14g2fKfUvzewamOqEidnDPAO04kx9JW1ZAIv
         Ou3KUC2EHYI+Ltb0qGwrdUoKKfFRxNrEO8iAljtjgyitBwkg4rxi26+vrKZ4myT4gQdY
         3zuKWAMRbFEtgacHydjHDV58pRFXJKpVqIyCru2fdRhV/SF050ENxLJHpKx+7lCenjBe
         1eCEmKW8OZI4rCIBz22/2phgqz+15DkYF6u/HnwMZATBgOwRpSMisWnHaftuASHfvN42
         5Ij/fSb2LbCgzyrS9esKQwoAflDmCTpgssVwkGcOCSU4WWdQ6fKPg32HjnzpenT5SzMg
         r95g==
X-Forwarded-Encrypted: i=1; AJvYcCV5I6m7jcQ9mPId85ZP9hh+q5fMZ03B/G3WbGev7NlXI0YN9pcwmWIk2zbaKpqtcm6JQSOxMjJHrltXVW1C8YF715Wc1kz6zeoVRS/o
X-Gm-Message-State: AOJu0Yx59CQIqMvCDBV1L7e2BFAhQsAXTf7W+5bbFJ9Yf9BBtx5MbvzZ
	zV2anYqg4nUDI46w1c0SC764dv58SQpBYN4f9NE8GRbPO/41fZnidtWYmyRBDCkSXEuUh0wwRv8
	2nAeCUQGr3iNai4ZfKf4AYYEYVNk0/3F0nMU3qA==
X-Google-Smtp-Source: AGHT+IFz5qP18mAylhBbmtThupMzDKv7Hxf/YKoxmcI8024bWwzwHlVosWJHVpjswkQo1H6JZ+uOIVvInsfVrUzL8aQ=
X-Received: by 2002:a17:907:26c9:b0:a59:ba2b:5913 with SMTP id
 a640c23a62f3a-a5a2d66b525mr199596766b.62.1715340236873; Fri, 10 May 2024
 04:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502212631.110175-1-thorsten.blum@toblux.com> <20240502212631.110175-3-thorsten.blum@toblux.com>
In-Reply-To: <20240502212631.110175-3-thorsten.blum@toblux.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 13:23:45 +0200
Message-ID: <CAJfpegsVWa-fu=DePSC0J1WkfQxhaqs0RTxopMBHduwMANieyQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] overlayfs: Remove duplicate included header
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, 
	Dave Young <dyoung@redhat.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 23:27, Thorsten Blum <thorsten.blum@toblux.com> wrote:
>
> Remove duplicate included header file linux/posix_acl.h
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Applied, thanks.

Miklos

