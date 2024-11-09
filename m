Return-Path: <linux-kernel+bounces-402632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4899C29D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D8D8B22540
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331B13B2B4;
	Sat,  9 Nov 2024 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VqXvFAA7"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E443ACA6B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731126092; cv=none; b=YafjYby4Jqienh8z2H4GGVi8/5CaF2BTeq2I4lB2Ldqnwo4SovYMtWNoGMFB8wEZ5w/N8Irn5jlF46L/SoErqK14sAlJt5b0bUgl6QqTNtGpAzJJsctD7rEZ6M5OklDRVEyQgdaynz1f0Um8PUQcFaCb3rsM8Q/enkQQ7BK1mnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731126092; c=relaxed/simple;
	bh=Kkv10Z56Vwnu3m8myms7xu90n7xB4ImdbVT3DJ3W1PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7vbdkN7kQIjcn9iC0+eUI+rkKxdafA3KpboS5hakMCJl0PnIXhrm/S1/GiNstGG+1Co2C5yGwKBFf4PVPf8DKjyWet4JXJpkZ3o6lxn9OSsoyl22oalQJIUplI+RbcymoniRnT4SPzg38ukNC2RNAF+c5H4mUnxShiZmHbDJyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VqXvFAA7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso3386483a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 20:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731126089; x=1731730889; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r3n8ZaaixM3CZjikXFdFGQi+PMbAs+VQQp6RfmiZHOI=;
        b=VqXvFAA7DucX3ZZKMkTLFhhXHWsVWodo2khKxI1OoBiU0/HQEQHhVmauVoeYmikaQn
         cDaObi+50wE0viyWPOeTunl8vtlr7rtR95V7vAMMCXI710YdRS0PQRQ59x1mZFq2M7gE
         dNGYMKwsM7nP+Bsi1OH6gng6V+/eVu+NgWM70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731126089; x=1731730889;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r3n8ZaaixM3CZjikXFdFGQi+PMbAs+VQQp6RfmiZHOI=;
        b=WKq9iIXIFheA6y6Iu00iTsZ/E92zNYWQPbX6YAyk/fZ+cIZ3rDpAx59Pue+laiF+KE
         mP49RFhPkMpmw1Gbh7P26nCSvsF+ahzQFGGF+JqFyMILkQSOveNO4TrrIz2EkuDqlTR+
         Nyx2rKebAFrgBbD0XaIuO+3hA+VNVbmtgrpBWb4GKULxJQoOQdbw41EZHFYj/u3HOaOf
         V2OQwfLsWYtLmvZRPy4HNSXOBqRc8vBMYE9Z+oZvFLqaSF7e0r45h6/FE9KWWHHxO9Fd
         skQjSyJQXWRNbsfmRXyb+xrWYRcls9Hviesge/x5cIFmWYOqHIHKWiW/9TJ3UHwQVbdf
         ZHVA==
X-Forwarded-Encrypted: i=1; AJvYcCVRrPJkNUciNW8S4H3HzAFQ7RhsBL/OpUnKICHCcY3UaxjLgMAvRoJbo8dbJw2WAkYytsTJfAHY8UPODZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEfZTZP5KWSqciqAIr/lCdItNnqsXFpfWAMNNgIA4caZtTS523
	MiruwTfaRmaqHWCTlx0OC7mzHEXgSEz00/luVC9sP1OnWvIntVneays9XwUGWUUFmwVssyvt7DV
	iQcjOtzfcqT0NFmHUsIhVdTIvelNxFChoEeCZ
X-Google-Smtp-Source: AGHT+IEbI8Zy3jHJWZ8emyCEGhlMje1/z5MRT5gRrLJjxrgY5yg5uMbMy0BHhLZGL1yYeXxJfr5TzI2/SQZCAJDTYQ4=
X-Received: by 2002:a05:6402:27c9:b0:5cf:f82:ea14 with SMTP id
 4fb4d7f45d1cf-5cf0f82ebd0mr3652436a12.5.1731126089209; Fri, 08 Nov 2024
 20:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <384c034c23d63dec14e0cc333b8b0b2a778edcf1.1731092818.git.dxu@dxuuu.xyz>
 <CACKFLimKe8Kp5f=RzvoDFmmjPv1ZvUjOG-8woEJ9XXLNSGtSmw@mail.gmail.com> <CALs4sv0gt7stf+ADcsi7Yt-X8SZ=gYZuYfk9sQCLzPOjaabFvQ@mail.gmail.com>
In-Reply-To: <CALs4sv0gt7stf+ADcsi7Yt-X8SZ=gYZuYfk9sQCLzPOjaabFvQ@mail.gmail.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 8 Nov 2024 20:21:17 -0800
Message-ID: <CACKFLi=CMdJNYH4R-Chpnt+LpvUv4_0nFmhzQp7E9f_YVbDeaQ@mail.gmail.com>
Subject: Re: [PATCH net-next] bnxt_en: ethtool: Supply ntuple rss context action
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, andrew+netdev@lunn.ch, pabeni@redhat.com, 
	martin.lau@linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a205bf0626733301"

--000000000000a205bf0626733301
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 7:10=E2=80=AFPM Pavan Chebbi <pavan.chebbi@broadcom.=
com> wrote:
>
> On Sat, Nov 9, 2024 at 6:19=E2=80=AFAM Michael Chan <michael.chan@broadco=
m.com> wrote:
> >
> > On Fri, Nov 8, 2024 at 11:07=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote=
:
> > >
> > > Commit 2f4f9fe5bf5f ("bnxt_en: Support adding ntuple rules on RSS
> > > contexts") added support for redirecting to an RSS context as an ntup=
le
> > > rule action. However, it forgot to update the ETHTOOL_GRXCLSRULE
> > > codepath. This caused `ethtool -n` to always report the action as
> > > "Action: Direct to queue 0" which is wrong.
> > >
> > > Fix by teaching bnxt driver to report the RSS context when applicable=
.
> > >
> > > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/driv=
ers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > index cfd2c65b1c90..a218802befa8 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> > > @@ -1187,10 +1187,14 @@ static int bnxt_grxclsrule(struct bnxt *bp, s=
truct ethtool_rxnfc *cmd)
> > >                 }
> > >         }
> > >
> > > -       if (fltr->base.flags & BNXT_ACT_DROP)
> > > +       if (fltr->base.flags & BNXT_ACT_DROP) {
> > >                 fs->ring_cookie =3D RX_CLS_FLOW_DISC;
> > > -       else
> > > +       } else if (fltr->base.flags & BNXT_ACT_RSS_CTX) {
> > > +               fs->flow_type |=3D FLOW_RSS;
> > > +               cmd->rss_context =3D fltr->base.fw_vnic_id;
> >
> > I think the rss_context should be the index and not the VNIC ID.
>
> No, for RSS contexts, we save their index in the fw_vnic_id of the
> filters. Hence what Daniel has done is correct.
>

I see now.   The index is stored in the fltr->base.fw_vnic_id.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000a205bf0626733301
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILq+xZxWOVcaIVPPbdDp+qf4oPebVobp
2o7gQpD5qlFJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTEw
OTA0MjEyOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBARqe0oQQTa0enbEzNJZG18zB+pBysqqGetgFCyEOyj9iFuSyu
1iDZKluqlr6ObQyx0M7x4OYJeEFxpTTfNnCIZUtya5SlA5pmGlFV5h1+SJw7+94LqDjTQjLwHXnf
8ESmWXSs/3wOO9UxGNH4rI+XCXkxb0xudJ5JnyQjw5Om+qmmZLhrxmYmaSG8+X9VV/Z8EtU8d4Vr
SZ0HQIW1MbxZoS8aGojb6bY4HE9grLOTQyFpmtRBWOa55dhCwN6YVN32hpjO5aE7S1P1wuSYItXB
r2UiHeG0Vb+vMYv8kzGYlJwg7kG/nfklFUdTNFYKBljF5fTsbCbPNOGWtBzLL5E+
--000000000000a205bf0626733301--

