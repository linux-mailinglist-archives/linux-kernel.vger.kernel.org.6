Return-Path: <linux-kernel+bounces-202554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C954A8FCDEA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91301C213B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F7195B35;
	Wed,  5 Jun 2024 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICyBW73T"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8ED188CBE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589394; cv=none; b=bsokXwOK1yF9kl2CLzq96VYzVoddjczVuTpXzXbS17P0KUg46pX/V8rs9JnF18vky0Z00aBsXDEqlCW/Ur0eLdkqNxhMA2hPNL37PiImexNyIHok7O3nzQUUT4R/YIHUKa/x+qDFOc3WcFpjRVYsoxr2sCJ7EWTim9JNqij251M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589394; c=relaxed/simple;
	bh=v6OkUYHTDnK30eTulYuTKHOA0EMuuGUmEQIuIvevXFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e52RluZc73i9TZofM7Lnlj7d5vwgeC7UnO3gNAsaCTxUmqbg+VwWihikuy3vAQ72igOoA+vKHY0+Ulvibk47V+owE+jvBjxqvelqCkAyltnoyAMM57T8NddTIjB599xkwaoYJX2ibl1vDqS0mPJnnhJ2VedDAmS+spcPpuV0nX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICyBW73T; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-df771cae64bso920804276.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717589392; x=1718194192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6OkUYHTDnK30eTulYuTKHOA0EMuuGUmEQIuIvevXFE=;
        b=ICyBW73TT4Sq64wrXk+Lt8UP8Akc+p5qY3XbgD82HVn8ggPcKkKnJyhKVHxk27KxAL
         r3gV13eMOQ0bw9fcdlTIlWUI8ipnbKwFo76nZTJu6FLL8ghnJPCxYSKsSC8pT1zOPKLT
         o80jmRwGk6FpSsU4J67AdDWx5UB1ew7NfxuFr84bBgKlIZLvlkaoVMFerBozbfY0waF1
         Rx0NZTCyPCPPXUaFzL+4L7As+I+W6Enamn8HXZcDUelubhgbhVdfHYe+lrykPWqW/75i
         Gf3Ulq+r/w+zks4jcA5D2nWQpMaDfaO7uGwvhPqWKBz/ZxZBi1LsQTyXfUQqR4QoZdW2
         JkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717589392; x=1718194192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6OkUYHTDnK30eTulYuTKHOA0EMuuGUmEQIuIvevXFE=;
        b=CvIUWPwqTX/7Va5VgNaJxTUW5dNvOc8Ey2X1c4RmmR2xEwQgoHlMsIq44YbKbV5KMR
         8biXcpVXaty6mxF9bEixJwsaiK1svh3KcPF/yCHdOv8zB9rCJknFb1A4XHzlwNw9z3f6
         Ka9bZC2JmNiEo1eQJ3vP5g2yImaG0bOfMjiFgTDeZaHLIH8Ba/5zjxtkG9+2guiake4k
         XMAKV9KQqtAlCHObSCfDRLZM9hR71CJ3Nxc2ougKPDyYkm80/R1DlTaRFwe/tzpoQ9y2
         rljHBM8IEK/nTWcR3yAINqPs46p1Tvlv195g6F2ojnocPw6c4o+Q50CYr6pYbWqBwpT+
         n18A==
X-Forwarded-Encrypted: i=1; AJvYcCWs4+Jt9IDnTRnzhc2KAVRVUrhbb1bM/Bs8piLB7kufgqFlZsrWJJPX7rxc8YKVbxJfHvBbj8BgYJLJIfAlbpzgZEA4Oc/A2vbPdobn
X-Gm-Message-State: AOJu0Ywmd7XnGYotixunTmkFSKlMCuGeivUGWQEqSvxqTn+QvwJqmDUB
	L36VLS92e9BbMb35upRo1oixeRiuDqywe1Bm6nviGdsSvUuCJ0VuOTY1jSYML8FtVmpSJtGqVVD
	tp6LAgh3fDAVltMPn8n8+afYE3GQ=
X-Google-Smtp-Source: AGHT+IFutQyTj0+V5BeNMKPgv6bKnZ2VEqST1PWMxEl6FvshfTzXV2urEFBL/wOmjSW7uaTvLYelQHMwWtqnN9amCXg=
X-Received: by 2002:a05:6902:260c:b0:dee:6ffb:b3ab with SMTP id
 3f1490d57ef6-dfacacca5a5mr1897470276.4.1717589392287; Wed, 05 Jun 2024
 05:09:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsOkiGxAfA9tPKjYX7wqjBZQxqK2PzTcW-RgLfgo8G74EQ@mail.gmail.com>
 <87zfso6tfk.fsf@intel.com> <8fb634f8-7330-4cf4-a8ce-485af9c0a61a@intel.com>
In-Reply-To: <8fb634f8-7330-4cf4-a8ce-485af9c0a61a@intel.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 5 Jun 2024 17:09:41 +0500
Message-ID: <CABXGCsPAdzVnSpT65NkMTi=jS1c0-bz=2XjnZWUkOxhrnkpgEQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] 6.10; regression; bisected - commit
 86167183a17e cause info msg "trying to register non-static key"
To: Sasha Neftin <sasha.neftin@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, vinschen@redhat.com, hkelam@marvell.com, 
	naamax.meir@linux.intel.com, anthony.l.nguyen@intel.com, 
	"Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Lifshits, Vitaly" <vitaly.lifshits@intel.com>, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 10:34=E2=80=AFAM Sasha Neftin <sasha.neftin@intel.c=
om> wrote:
>
> Any thought? Revert?
>

Sorry for the noise. Is there any solution?

--=20
Best Regards,
Mike Gavrilov.

