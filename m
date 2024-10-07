Return-Path: <linux-kernel+bounces-354231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419F993A58
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881051C23C9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8AC18DF8D;
	Mon,  7 Oct 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V7T9LO2N"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF60218C00D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728340761; cv=none; b=Kd+W8nAcYn8BED8LLYAohvZsMZwnCGYGRck4lfPqEUzV/13v9y6F0+IQX07eeKSTRRbeJeBpblf9rv0G++V8rDw7P+HsDWxZBTUuGQZ83YeiuE2tQ3yELKlzRvp7oRNiaYv7Ox5mMFMmVJTnQyqP+4iX5M5Weo9PSu9OCew6aWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728340761; c=relaxed/simple;
	bh=tSiNpe2FjtDieuEeNI68se2l30utwcryxaoRXcBg5DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=f2ODjwkxgFGyn0HrjTAJjVzOSgcdv+BlafcPx2It4elT70ptmOhr4S2bQ6Bx+hf65DMmAXelX88qIwT5kvFoVU+PHLghuoSrRFlNeCqJGAefMpfNgl8d708bukWNXWYg80lB4k0jgUld52qUemastO88+EDE6wWMpueO1gqAeGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V7T9LO2N; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so753480a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728340758; x=1728945558; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yq5b6RbyJ9bYlDYYMMyMUKq/8hffGCC7Je9c9kwlgzU=;
        b=V7T9LO2NozLYYapuJh+3ORB5NyDJI/jLKuQLC1Xevy6gvLwpGbSRkZzzVjXcRkxSPo
         iNCZuK7fIZbqVTGg5L1YMU4XBaTq1WvsRPi3o8/r3u4oD1f3tb8HkWyBtVDCToDG3JdD
         ha9xN75HBpvql100tHda13KwYX5b0/wHXdqEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728340758; x=1728945558;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yq5b6RbyJ9bYlDYYMMyMUKq/8hffGCC7Je9c9kwlgzU=;
        b=EQPD+FHMuTEDDJY1Mh6eCNbzgU4qFX0khDETdcSauK2y1h5xhyDoIDY2r2/Wqe4RW0
         DKUIk7rcxkT+2rsqX6uFsKKLxKn2tboMlV7R5jlbD1vyVMWO2fa5xbcozKGfXDg3kVm2
         nYd1aT+sPvNOgl3yLJPFMjLUWd8fx8YxbN7weezuFmmCdgpmiTvl/x04w7zazkxJfBHR
         0InPaMMj8KDS9FDg7xuxoHG486RazkfVsKKgpUXxsrz8g4ksQo7UnTAwTQq2soTzxiua
         77fgEspRbB3hDRcA0QjifAgEPZwT1fLoko22DWV+hvsFMwEvEtp7BfgUhku2K+a3oC/N
         +cGA==
X-Forwarded-Encrypted: i=1; AJvYcCVV1sF8uRy/WPGYuPlOTpupSB59PbNn3lq+sPiiMekV4jnnQrc2HL7euGWZW2Huca5yBLzTXux2kNigcno=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBylYDZBkCR/1S3u6Mui4NukDSpzVJ484SBVkmGMmSsNQ+iK24
	JNQXeWv9xNQFmEEREwGZK+Z4a+kC5A3ZzsUY+dHyGlLHCnq4qe75gtZI1PON4fW+Wkeo+yeN7Nz
	Mp1jdCABJM3Du5Y26/QbqQqd46EbN4UrR/4UB
X-Google-Smtp-Source: AGHT+IFHo+Ro60KWqoi1BRTaNTsQW+lKcm3ae/JwOHrlrPzpbSWSdE0JfJ6b+Xhq7JHjqC/nSODeeyYzMjIOanOlrpc=
X-Received: by 2002:a05:6402:3490:b0:5c9:6c7:8b56 with SMTP id
 4fb4d7f45d1cf-5c906c78b97mr559151a12.7.1728340758083; Mon, 07 Oct 2024
 15:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005145717.302575-1-jdamato@fastly.com> <20241005145717.302575-3-jdamato@fastly.com>
 <CACKFLiknyPntcYXrhsVkz5Mpt9kep0cnkYBGVb1f74x5+HS4Cg@mail.gmail.com> <ZwPu7DmYwwK_uDmD@LQ3V64L9R2>
In-Reply-To: <ZwPu7DmYwwK_uDmD@LQ3V64L9R2>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 7 Oct 2024 15:39:06 -0700
Message-ID: <CACKFLi=TNxacUwG4BaFwRmfLq42fFxtrAmES5Gm4bt4yt+Y15Q@mail.gmail.com>
Subject: Re: [net-next v3 2/2] tg3: Link queues to NAPIs
To: Joe Damato <jdamato@fastly.com>, Michael Chan <michael.chan@broadcom.com>, 
	netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f5e05f0623eab02a"

--000000000000f5e05f0623eab02a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:23=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> On Mon, Oct 07, 2024 at 12:30:09AM -0700, Michael Chan wrote:
> > On Sat, Oct 5, 2024 at 7:57=E2=80=AFAM Joe Damato <jdamato@fastly.com> =
wrote:
> > > +               if (tnapi->tx_buffers) {
> > > +                       netif_queue_set_napi(tp->dev, txq_idx,
> > > +                                            NETDEV_QUEUE_TYPE_TX,
> > > +                                            &tnapi->napi);
> > > +                       txq_idx++;
> > > +               } else if (tnapi->rx_rcb) {
> >
> > Shouldn't this be "if" instead of "else if" ?  A napi can be for both
> > a TX ring and an RX ring in some cases.
> > Thanks.
>
> BTW: tg3 set_channels doesn't seem to support combined queues;
> combined_count is not even examined in set_channels. But maybe
> the link queue can be a combined queue, I don't know.

tg3 is a little odd.  When there are more than 1 MSIX, TX starts from
vector 0 but RX starts at vector 1.  If there are more than 1 TX ring,
the 2nd TX ring is combined with the 1st RX ring and so on.

>
> Regardless, I'll still make the change you requested as there is
> similar code in tg3_request_irq.
>
> But what I really would like to get feedback on is the rxq and txq
> indexing with the running counters, please. That was called out
> explicitly in the cover letter.
>

It looks reasonable to me.  Thanks.

--000000000000f5e05f0623eab02a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHsj7NvKj7mSIpCXZbYzCn+K5tqmj6Yl
v/AUP9bqYN9IMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTAw
NzIyMzkxOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCQI7kbYcl3hLp7svyBqouRUXmTIqpepl8ZkDBS2jYJzLCCZ5Dr
ozEsNUMf3WXrbsklFZ65FjAGIJJsrpCrd4pIxQ3EL9aEgwlc8NEV6lL+LbFizTSjJgLt9HEknLQE
ulKaxMrparOkjSI+dZS/bakCOh4+iW+oETIBVVLQ59GUFbbuD7ilKVFygOc1EuFv+oOUw9Dzs7Ka
1r5WYFzPIW4wQY24UxQeUtEHf88YXCMNhVySPdQ67NnDY5CiNGcmhQ0qNUKlARtFPMYdeL1cxCjH
JBAr7mkNfa0ssrEQOWOL0Q/jf75bB0Po3pxAMcYV5Z/OzHsZGvm2hKssg55SMa4X
--000000000000f5e05f0623eab02a--

