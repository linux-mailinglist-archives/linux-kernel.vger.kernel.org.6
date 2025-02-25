Return-Path: <linux-kernel+bounces-531489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7BCA44117
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FCA3AA2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A626A0AC;
	Tue, 25 Feb 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="YdBg/fK0"
Received: from enterprise01.smtp.diehl.com (enterprise01.smtp.diehl.com [193.201.238.219])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97825EF8A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.201.238.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740490765; cv=none; b=hNTGECAbUTuCIYC3saxl/F3tBpmsKxuQZHjUODpIOd+K/zWk1oQKPd5E22IK+4jG09Gzc2ma81m4ZUQr4vrmu/KOjnlw/4dxK4jQ7aKt5MSXSaNWp3v1ikpwyf8/uOwiJIas4Cqm4JrI77qmFFCCFFzVltfXvYctyWuCbKCg5EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740490765; c=relaxed/simple;
	bh=2wEnpmybEOTA3qrxI/TpaLHqhzpMVZSN/eaRpQizBuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGFJeoy9pSPJTtS5iJpWcdajutTx12BgvY1nVVKMATVhb6TvU9CcIBNDKZcHDkDEamNTqyWSeCv/TTcFow1J1t03eSuUfdoZ8QJzIL6Un6V4AOxaRxoLHkIn4nHRkqJvhhVc2uApYTM3TUS8kBDhhXUmt6u7xs8A7fcb4pGpWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com; spf=pass smtp.mailfrom=diehl.com; dkim=pass (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b=YdBg/fK0; arc=none smtp.client-ip=193.201.238.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=diehl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=diehl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1740490762; x=1772026762;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=SEnsjfppjS5vAzmEhzN3BlDWZEw2WQAfQIQDIxiESSc=;
  b=YdBg/fK0eyJPYPU3KqrTeCojOA+5wuoeJKH9SqXPPf/IZjxzvcvSmGdX
   4na63+Wbl6/6gWaQFY9f4l2TzMzzvcZIr9ZtNoYfhLsKQ7P32RuNgiXas
   JqGWwQaX5OaAh4rbCV3EUdvoN2fe4O0j1R3agrwxY4YVtoshlE7U3p1iK
   PgoIzN3AKYJ2brTMLusW1aKWux4XclCdXPYKMRdJBQim0lURuj1Z7GyhQ
   whnJxyfeO6Mp+LmZIy8pC+wzBmpbL0RcDlCu+pO7Q6DVPQHSWnBaBMc94
   HQEQQdLhN+yHMYQXVzp+UdbJBXxbN02M/j73N+MOx2unLbNpKYRK66ONU
   Q==;
X-CSE-ConnectionGUID: QqAyOCHRTeSTf5proEriEQ==
X-CSE-MsgGUID: k23hCgFQR8Kgyrfih7/UAQ==
X-ThreatScanner-Verdict: Negative
IronPort-Data: A9a23:l5T4xKD92oWEzhVW/wbkw5YqxClBgxIJ4kV8jC+edVH5lGZ7hGRDl
 z1BRiGbeqTZIWXoOIAhNtzysAhTiSLnvpU+EV85s2kyVBqmwuKbXInAc0v7Y3yff5fPQEhqt
 p5GO4eRJcxqFnPS+kbyY+Lr83Qlja3YTOOgA7XNNyt9S1Q4FXhw0UlolbUy3N4z6TTVKwqVo
 dfzqMTDOVijnCZ3OXlLrrmCpxVmoOnotVv0m3RnDRwclAGGzCl94OsjDaGtM2OqBc5dH+f8X
 PnC16qi/2zfuRwtTdqkiPOhLERVG7WKbE3S1XdcHvT/3xEH9yZoguNnPvZDM0tZ02TTz9wp8
 pYVP3R4Zwc1IrWe36MaWAJAVTphPLZd477IJz60sYuIzkLANHzn2LBnBUo9NoAUp6MpX2wes
 KBAdmFIPxrajae4zOjqQ+Mz3cktIcKzJr53hp0b9t2vMBpcacuFG833zd9EwC9iwYdHHP+Yf
 NUYciF0bRvGJRZPfV4WEtdilbim3yavI3gC9ljI4PZn7mOWxVEtj/3madHZItaEHJpexUrAm
 wr6Ex/C7mcn2Ka3knzdmk+EhvPThXG8H4kIEPuj6f9xm0aSyWpVAx1RXlej5KK0hxPjVd4Db
 hFFoXpr8fE/+Qn7FNX3Gkbi+iWNtRMSBtEKSLUHgD1hsZE4lTt1fEBfCGYpVfQmqNMuF3tt3
 UWN2cj2BCd0q7yaTzSW9vCfoSv3NHlKIzddbnNBQFVev5y/q4w4y0LCFN8mSPK/1IX8Rjirm
 zvX9BVWu1lotiJ96knB1QuB21qRm6X0oi4JCiT/DjL4tl50b9H4btL5uAXRt6oaId6TRACI5
 CNawZGV57lSVMHcnyGzG+hcR7vBC9RpktH/qQM1Q8Nxp2zFF1qLJ904DORWfR8xWio8UWa3J
 heV4UUJucM70EKCNcdfe5i2B9kh0Z/uHNHkUuG8RtdVa/CdTifelM1VTRDWhjuFfHQEy/llZ
 M/BK5v0Vx72NIw8pNaIb7ZEuVMU7nBmrY/jbciT5wiq17OYeEmURd8tWHOSbvo05b+zuw7c9
 dBSLaOik32zh8WnP0E7WaZKRbw7BSBT6aLe8qS7RcbaSuZSI1zNPteKqV8Xly6JqIwO/gvA1
 inVtka1UzMTj1WfQemBQigLhL8Cwf+TBJ/0VMAhFQ/A5pQtXWqgxJ4GXooQVpkdyOFY8fApV
 +MCVt+BL80aH1wr+xxFBXX8hIBnZh+kmlrUeSGieiB5c59tRwiP8djhFuft3HBWSHrt85Ju5
 eT7jGs3QrJaL+hmJMrbbvO0iVSqoXUHnOt0U2PEI9RTfAPn940CxynZ16ZreJBdckWSrtec/
 wXMWhczqsf0md8W/8jTi6GE8MCUOtIrSyK2GEGet95aLxLy8WukxIJcTOegcDbbWW7y/qjkb
 uJQp9n4MfsajBNJvpB6HrJD060z/Z3sqqVcwwAiG2/EB2lHEZs5ej/Wh48W5usUneUxVRaKZ
 39jM+JyYd2hUP4J2nZITOb5RoxvDc0ppwQ=
IronPort-HdrOrdr: A9a23:t0QZ0K28yfeEaqVfiBe0FwqjBTtyeYIsimQD101hICG9Lfb0qy
 n+pp4mPEHP4wr5AEtQ4exoS5PwOk80lKQFqbX5WI3PYOCIghrNEGgP1+rfKnjbalTDH41mpO
 xdmspFebrN5DFB5K6UjjVQUexQpuVvm5rY5ts2uk0dKD2CHJsQjTuRZDz6LmRGAC19QbYpHp
 uV4cRK4xC6f24MU8i9Dn4ZG8DeutzijvvdEFM7Li9izDPLoSKj6bb8HRTd9AwZSSlzzbAr9n
 WAuxDl55+kr+qwxnbnpiPuBtVt6ZTcI+l4dY2xY/suW3XRY8GTFcdcsoi5zX4ISSeUmRQXeZ
 f30lId1o9ImgnslymO0GbQMk/boXwTAjbZuCOlqGqmrsrjSD0gDc1dwYpfbxvC8kIl+Mpxya
 RRwguixu1q5Lz77VTADvXzJmRXf3CP0A4fuP9Wi2YaXZoVabdXo4Ba9ERJEI0YFCa/7Iw8Cu
 FhAMzV+f4TKDqhHjnkl3gqxMbpUmU4Hx+ATERHssuJ0yJOlHQ8y0cD3sQQknoJ6Zp4QZhZ4O
 bPNLhuidh1P7krRLM4AP1ETdq8C2TLTx6JOGWOIU7/HKVCIH7Jo46f2sRG2AhrQu168HIfou
 WxbLoDjx9MR6vHM7zx4KF2
X-Talos-CUID: =?us-ascii?q?9a23=3Ask0lzWtoIFOOSQDTvtgDj45X6Isca1TM61zwGXO?=
 =?us-ascii?q?1MlpnFaWPTnKK+Y5dxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ad/heMQyb5f/abmqNh+EYSnt05IyaqKf0U0Amnrs?=
 =?us-ascii?q?/gZmnOj1qNTad03OKa7Zyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="p7s'346?scan'346,208,346";a="114399389"
From: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH] pps: add epoll support
Date: Tue, 25 Feb 2025 14:39:20 +0100 (CET)
Message-ID: <05ac823e44504921a6e864fe6fb283d6@diehl.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----73086AE8A529CA972B53CC1FB9035D36"

This is an S/MIME signed message

------73086AE8A529CA972B53CC1FB9035D36
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I fixed-up s/pps->fetched_ev/pps->last_fetched_ev/ and tested it.

With one process it works well.

```
# cat /sys/class/pps/pps1/assert; PpsPollTest /dev/pps1; cat =
/sys/class/pps/pps1/assert
1520599383.268749168#29
assert: 29
time: 1520599383.268749168
assert: 30
time: 1520599384.292728352
assert: 31
time: 1520599385.316788416
1520599385.316788416#31
```

If I start multiple user space programs data races are visible.

```
# for i in 0 1 2 3 4 5 6; do PpsPollTest /dev/pps1 > log$i & done
# sleep 6
# tail log*
=3D=3D> log0 <=3D=3D
timeout
assert: 196
time: 1520599554.276752928
assert: 197
time: 1520599555.300692704

=3D=3D> log1 <=3D=3D
assert: 193
time: 1520599551.204723248
timeout
assert: 196
time: 1520599554.276752928

=3D=3D> log2 <=3D=3D
assert: 195
time: 1520599553.252784688
timeout
assert: 198
time: 1520599556.324909152

=3D=3D> log3 <=3D=3D
assert: 195
time: 1520599553.252784688
timeout
assert: 198
time: 1520599556.324909152

=3D=3D> log4 <=3D=3D
assert: 194
time: 1520599552.228723584
assert: 195
time: 1520599553.252784688
timeout

=3D=3D> log5 <=3D=3D
assert: 194
time: 1520599552.228723584
assert: 195
time: 1520599553.252784688
timeout

=3D=3D> log6 <=3D=3D
assert: 194
time: 1520599552.228723584
assert: 195
time: 1520599553.252784688
```

From my point of view it would be great to fix this bug without such an =
limitation.

Regards, Denis

-----Original Message-----
From: Denis OSTERLAND-HEIM=20
Sent: Tuesday, February 25, 2025 1:47 PM
To: 'Rodolfo Giometti' <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Re: [PATCH] pps: add epoll support

> Hi,
>=20
> -----Original Message-----
> From: Rodolfo Giometti <giometti@enneenne.com>=20
> Sent: Monday, February 24, 2025 6:39 PM
> To: Denis OSTERLAND-HEIM <denis.osterland@diehl.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] pps: add epoll support
>=20
> > The idea is to use poll to wait for the next data become available.
> > The should poll work like `wait_event_interruptible(pps->queue, ev =
!=3D pps->last_ev)`,
> > where `poll_wait(file, &pps->queue, wait)` already does the first =
part,
> > but the condition `ev !=3D pps->last_ev` is missing.
> >=20
> > Poll shall return 0 if ev =3D=3D ps->last_ev
> > and shall return EPOLLIN if ev !=3D ps->last_ev; EPOLLRDNORM is =
equivalent[^1] so better return both
> >=20
> > In case of ioctl(PPS_FETCH) ev is stored on the stack.
> > If two applications access one pps device, they both get the right =
result, because the wait_event uses the ev from their stack.
> > To do so with poll() ev needs to be available via file, because =
every applications opens a sepate file and the file is passed to poll.
> > That is what my patch does.
> > It adds a per file storage so that poll has the ev value of the last =
fetch to compare.
>=20
> I agree, but are you sure that your solution will save you in case of =
fork()?=20
Well, I have not tested it.
I would expect that regular files behave the same and a read in the =
forked process influences the f_pos in the origin process as well.
So this would be not supprising that the fork may "steals" the poll =
condition.

> So, why don't simply add a new variable as below?
If more than one process opens the same pps, they refer all to the same =
pps_device structure.
They have all their own file struct, but that refer to the same =
pps_device.
I guess this leads to the situation that only one process sees the =
`last_fetched_ev !=3D last_ev` condition, but I will test.

I will give your patch a try and report.

>=20
> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index 6a02245ea35f..dded1452c3a8 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -40,8 +40,11 @@ static __poll_t pps_cdev_poll(struct file *file, =
poll_table=20
> *wait)
>          struct pps_device *pps =3D file->private_data;
>=20
>          poll_wait(file, &pps->queue, wait);
> +       if (pps->info.mode & PPS_CANWAIT)
> +               if (pps->fetched_ev !=3D pps->last_ev)
> +                       return EPOLLIN | EPOLLRDNORM;
maybe leave poll direct with error condition, to signal that this is not =
support instead of normal timeout behavior

+	if ((pps->info.mode & PPS_CANWAIT) =3D=3D 0)
+		return EPOLLERR;
+	if (pps->fetched_ev !=3D pps->last_ev)
+		return EPOLLIN | EPOLLRDNORM;


>=20
> -       return EPOLLIN | EPOLLRDNORM;
> +       return 0;
>   }
>=20
>   static int pps_cdev_fasync(int fd, struct file *file, int on)
> @@ -186,9 +195,11 @@ static long pps_cdev_ioctl(struct file *file,
>                  if (err)
>                          return err;
>=20
> -               /* Return the fetched timestamp */
> +               /* Return the fetched timestamp and save last fetched =
event  */
>                  spin_lock_irq(&pps->lock);
>=20
> +               pps->last_fetched_ev =3D pps->last_ev;
> +
>                  fdata.info.assert_sequence =3D pps->assert_sequence;
>                  fdata.info.clear_sequence =3D pps->clear_sequence;
>                  fdata.info.assert_tu =3D pps->assert_tu;
> @@ -272,9 +283,11 @@ static long pps_cdev_compat_ioctl(struct file =
*file,
>                  if (err)
>                          return err;
>=20
> -               /* Return the fetched timestamp */
> +               /* Return the fetched timestamp and save last fetched =
event  */
>                  spin_lock_irq(&pps->lock);
>=20
> +               pps->last_fetched_ev =3D pps->last_ev;
> +
>                  compat.info.assert_sequence =3D pps->assert_sequence;
>                  compat.info.clear_sequence =3D pps->clear_sequence;
>                  compat.info.current_mode =3D pps->current_mode;
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index c7abce28ed29..aab0aebb529e 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -52,6 +52,7 @@ struct pps_device {
>          int current_mode;                       /* PPS mode at event =
time */
>=20
>          unsigned int last_ev;                   /* last PPS event id =
*/
> +       unsigned int last_fetched_ev;           /* last fetched PPS =
event id */
>          wait_queue_head_t queue;                /* PPS event queue */
>=20
>          unsigned int id;                        /* PPS source unique =
ID */
>=20
> > If you want to avoid this extra alloc and derefers, we may use file =
position (file.f_pos) to store last fetched ev value.
> > The pps does not provide read/write, so f_pos is unused anyway.
> >=20
> > I am a little bit puzzeled about your second diff.
> > Every pps client that uses pps_event() supports WAITEVENT, because =
this is in the generic part.
> > To me not using pps_event() but reimplement parts of pps_event() =
seems to be a bad idea.
> > That=E2=80=99s why I thing that this diff is not needed.
>=20
> All clients specify their PPS information within the struct =
pps_source_info, and=20
> if for some reason one source doesn't add the PPS_CANWAIT flag, we =
should=20
> properly support this setting.
>=20
> However, this is related to the poll() support, and we can defer it =
for the moment.
I see. Maybe it is easier to reason about the details when a real need =
araises.

>=20
> Thank you so much for your suggestions and tests! :)
You=C2=B4re welcome.

Regards, Denis
>=20
> Ciao,
>=20
> Rodolfo
>=20
> --=20
> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
> Linux Device Driver                          giometti@linux.it
> Embedded Systems                     phone:  +39 349 2432127
> UNIX programming
>

------73086AE8A529CA972B53CC1FB9035D36
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIXkgYJKoZIhvcNAQcCoIIXgzCCF38CAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgghPaMIIGpTCCBI2gAwIBAgIUPseeE9qJ+oSdbny5LvEHTpzUCAIw
DQYJKoZIhvcNAQELBQAwUzELMAkGA1UEBhMCQ0gxFTATBgNVBAoTDFN3aXNzU2ln
biBBRzEtMCsGA1UEAxMkU3dpc3NTaWduIFJTQSBTTUlNRSBSb290IENBIDIwMjIg
LSAxMB4XDTI0MDUyODA4NDExMFoXDTM2MDUyODA4NDExMFowUjELMAkGA1UEBhMC
Q0gxFTATBgNVBAoTDFN3aXNzU2lnbiBBRzEsMCoGA1UEAwwjU3dpc3NTaWduIFJT
QSBTTUlNRSBNViBJQ0EgMjAyNCAtIDEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAw
ggIKAoICAQC6Dz+IfbUsaCl0cWcbnNS1BIaKrdka8ev1Kc1G6OCYH4PMtkZmC6Zo
nnh/Dl5bOuiH+pMq1fj4BSEkRYTuOGtsWelcf6UNA11KL//zh1enaaNayqqRaCSE
JTZH+JFb0UJWwO+qGVb1RfHnPXYrI6n8w1chCxL9AibzvsDPR6I37iUwiNo4p6Uo
aPNAmIncpDIGgTGodkOjjPPbGwYjg58eINT63rqMQASJxUnPPIa0gZRix0NY7A6U
z8Iv98RbbQy7ZEDvHdLFeVmzl/5TXKbQExfnEpyOjjifWoJ+FeKkEj4O9Ohd/2fg
HQ6Y+DYwLFbHZPTmDvHQoOSS//V2NBkdnGTsfIcziIH1hypFxR/hqexJ+Da7Z7uN
jBh2ligdXNHDGMeq640X2WVx0sfSZljxbeknrr3KFfzqfealPps1UI68Q+1iBLl/
Ep8aZeRmzwCK+ibAPQpKfbxsjd8cBe8FcXaOWU4DjP6YmYy0xMC4vHXr3ZgrHqL9
8D56InfiYbrBMZp1UKDSzlz/rjXWRmrXnsY5gFU705KWrJu2guSYCrc4InG3Pj+E
mPmE6Eosikk2wg90nYFxJDM/9dPJnyIw6IdkV6qdrv9h7VKrpLrl22qETWC4/Xfi
JU7YsY6HFKnpAElKu8t6rUnU5GcwgWjcB+zBfQD1Kt59jlLob2PcDwIDAQABo4IB
cDCCAWwwXAYIKwYBBQUHAQEEUDBOMEwGCCsGAQUFBzAChkBodHRwOi8vYWlhLnN3
aXNzc2lnbi5jaC9haXItNGE3ZjE3ODgtMjZiNS00OGVjLWE1NDctYzFjZDBiZjE3
YzNkMBIGA1UdEwEB/wQIMAYBAf8CAQAwQAYDVR0gBDkwNzAJBgdngQwBBQEBMAkG
B2eBDAEFAQIwCQYHZ4EMAQUBAzAIBgYEAI96AQMwCgYIYIV0AVkCAQswUQYDVR0f
BEowSDBGoESgQoZAaHR0cDovL2NybC5zd2lzc3NpZ24uY2gvY2RwLTNlZTU1ZmQ0
LTU5MzgtNDFlZS04MmRiLTMyMjNhY2VmNWMyMzATBgNVHSUEDDAKBggrBgEFBQcD
BDAOBgNVHQ8BAf8EBAMCAQYwHQYDVR0OBBYEFL+0FkGip5/XTYUBCqFcvtvF0uWU
MB8GA1UdIwQYMBaAFMwurYmMg+NAoyVppeqSfdI3OsfGMA0GCSqGSIb3DQEBCwUA
A4ICAQBGpYYvkjNsVP7geKv1jY+KtUNmyx8vlCoOo8tZ5Cc76175ocrVs50lZit+
nHWXe9Lqnuu1fMo+0jEpgC9dqy6cCxAEgNH5kwbFxXFPHOB/kxMdWubZ1xwcOP2l
B4ns7Ps9RUGOIcpfuAp2KLYwavjO58g+6FVGhY3R6VAhmNRO6bHhz0wQRwKAZNo2
GMwYMmxW63mI4bz1JYvCSeZtqZhyxTMDOwEUDdYkxrz3g5gQUoMnrrak1kGRdpFB
Eefok8aK8ngfwwIgefNBF9BnzoRhlIVrm3//zboqShj4IXqMEUgScWNz2WTjqKaU
uhLk+MyynNqrbp6EeFZ0BPgA7AfVWevRf4OOCxrH6S4FJtMKmuczZ0wqebTML7Ax
VtkSqeT7/NBDTh8D8j+HVvHwMi4s+cunS3DMdXE9yzuixlcjfsD/2aS17quE23Qf
nNESdDy5TUs5Wlm1ClYQ+L1cZGwSwAyqMs9RNg57+gtJu5Uhjn+FGVLndGQgzIor
/+ynq6KEzN2rhGzLpPHpwUdDoX+YnNlrZpdx/IOgknaSGznJ/mQzA6PjffNS0Fx3
pqd41QO0uX5HWDFEa/gG0Uo7faymzXFcFb9AKCrKR5Xrd0W+f2U2z/hvC843i9q2
8CoJ7xRMt0wF8Sun9U278iaLgPNNyCNDJorz9NmIomvT45XK7jCCBe4wggPWoAMC
AQICEACzBRGxFrSgVlEdfGgfh30wDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMC
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
bIRutw/gmkT7b9aP2Wmm3PtjnasrM+RdDlfGKqHkeCR2zkeRDDP2BE2LKc9CFGJB
PysNjZSVlp5/fxb8atVwVk+TphIHuHjeP+3z/ykiDr64Yq2yjyNlXrWVg2yxju4M
LdX8wfkCx/uAIlYLACinK+/RATAYz1f3Y+kJ81CQbfFpnFZBRhxjDfj65zxMrWsJ
ydnoGsZUHt7zXFOQvw7JrFL/X5s7hBv/3uy107vBwcA8Hyw9m3DH/ChBMen6gyy+
CkNXalP9AOZ66CoEgIE8PfsrzfBVjVxQq2+iQLNlJ8a1r6URPNd5h1YZILBy6yTK
8tUs5MbM2CjbXAylEC1P02GFKhh/aN0gW5RTRk3vpA64KPQ/ckvUTmHVWONUE9cj
iE1/MVDuc+tMfQus2HBQ0LH+EKaVZmsA1OEKujelRFleMEpBBWS0fQ+zT2Y4bfPZ
RB5iQLGLf9hSacG+ib5cid44OL6s9kjzE5+Yy70LNcoHwIaQzqoc6t7sFNVDecMc
tTbrs+raTu/cOMSc45aEDKXjhYw46cyuLwnY9DauweK3K89jUrCNqNqPwQke6QID
AQABo4ICCzCCAgcwgbIGCCsGAQUFBwEBBIGlMIGiMEwGCCsGAQUFBzAChkBodHRw
Oi8vYWlhLnN3aXNzc2lnbi5jaC9haXItMjZhNzFjMDktNDdlYi00NTVhLTliMjgt
NGJkNzJkZjA5MjhkMFIGCCsGAQUFBzABhkZodHRwOi8vb2NzcC5zd2lzc3NpZ24u
Y2gvc2lnbi9vY3MtYWFjY2NlZDUtNjZlOC00MDY5LTliMWItZmQyOWFiNzNlZmVj
MHIGA1UdIARrMGkwCQYHZ4EMAQUBATAIBgYEAI96AQMwUgYIYIV0AVkCAQswRjBE
BggrBgEFBQcCARY4aHR0cHM6Ly9yZXBvc2l0b3J5LnN3aXNzc2lnbi5jb20vU3dp
c3NTaWduX0NQU19TTUlNRS5wZGYwUQYDVR0fBEowSDBGoESgQoZAaHR0cDovL2Ny
bC5zd2lzc3NpZ24uY2gvY2RwLWU5N2YwN2M0LWU2MzQtNGNlYy04ZTJhLTA0YjIw
YTdhMzBjNTATBgNVHSUEDDAKBggrBgEFBQcDBDAOBgNVHQ8BAf8EBAMCBaAwJAYD
VR0RBB0wG4EZZGVuaXMub3N0ZXJsYW5kQGRpZWhsLmNvbTAdBgNVHQ4EFgQUcDNC
rQBRcB88zSaXlCXZiARXNi8wHwYDVR0jBBgwFoAUv7QWQaKnn9dNhQEKoVy+28XS
5ZQwDQYJKoZIhvcNAQELBQADggIBAGERoOSFwVyjYxyHmyClfw+npR6u+lM65HIH
REUcqiHtzZWVg5fFgcvp4aSgnHDl/LA+cZh1c8oymzZ5NJK7OGUEK3IpcIVhjFl7
ST/cg29MZy/5C8rWMWWXLjNxaepRN8e0zCxdGSm0nL5qUlPnREay35c19edhvgog
IBywGTMpVpWvkKkm0XW1q+yK7Nu17UbdlFzPFvIuuvxU/ytTK3V7UCTzZQeRzsuy
4Nn67ulycgMuVgVnhC8ar1imejfNMTORfcHz+MavkBbEp4IHh3ZGTd6R3U2KWkod
e2VnU3pGWD7GUefrUHyyRlIVjdnWbSnCrbdpc2BznYl8PbVHcipRvq3BRSfC5j4t
MOlGJ779WrFLEiEvu8iNUtAAd6/ha8vQRelTHE0HZWDWeND/NYPemmaK7waicfa+
TXbGEi3HkaJWmy266iw2SEEHYszzeFJVq8uRjxFUdOCRZvsfD6yoY6hchKoXRpkW
v8oW5LUTlhNfUZT2lRhkCwDdXh1wWzZgZZtx1VmVvYgfQg0RxMVdtqOsj4wpDkUU
dqnPfobQPmOxrrHqpwLH4sprjIBVmbAIVOHgyhlN31RbUcdyCsRqLIK4srhv1Qqj
IdMcphv3O2TqF/2mE64g/uinQq7uVqo7Yy0XDATNQ2g4gv/wliv5raoo7geyVNqJ
kT04CA2CMYIDfDCCA3gCAQEwajBSMQswCQYDVQQGEwJDSDEVMBMGA1UEChMMU3dp
c3NTaWduIEFHMSwwKgYDVQQDDCNTd2lzc1NpZ24gUlNBIFNNSU1FIE1WIElDQSAy
MDI0IC0gMQIUcJ9Pf3gC81On6JsQ/RWezTqDIbUwDQYJYIZIAWUDBAIBBQCggeQw
GAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUwMjI1
MTMzOTIwWjAvBgkqhkiG9w0BCQQxIgQgkv+bAFwtsOi7jhJlKzWXFnxMhOeV204K
nY8SvmAg0MkweQYJKoZIhvcNAQkPMWwwajALBglghkgBZQMEASowCwYJYIZIAWUD
BAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYI
KoZIhvcNAwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEB
BQAEggIAbJNZeJqvGXb88RDWneO8D/kVRJKc423y8NWaeismUOoeVi3UIVG2UfgT
S8bxqW8T2KZga0HnkfDNpTx4+eA1x6wHg7Rh603gjGwzqiFUzl6c1RUTfreN33wG
GD/Z1gJihakby0wWzTGlCuWiZqFaJ2LxJ415gOeIQDh0enkXkin8lvDE/JgmsRhf
InscZptayGurTXNUKQcKxi7TAqI1+POrjP0gJ1o8O6HiZUy63OFQ19cL2Hr/T8hf
E/0wAUUEg+0LQiXd0BNyxDNXhpD3IdC+EuSdRVlpwS5lIlBT2rDmag/1R28yjdTd
sZJHvXRHepQioht9LDAyz/SbO0214qDDqYPzW4RxpjvRBPWv5Ul0VdnmvQEjbYtc
a+k9Yr7TQlUKonDuHAOFA9lhI5Nw9s0IebvCscP0IBhW+FMiBYyyCuxgszr5JqaI
Dtcifm1lwOo2yOOamD9ddzTncjy5j4tSuV/mkQJLVPCJPM4kVqbnbsiw1/KyA2qP
I1zDj7y3ZVfmEjQFvYOY3SyYay2fXQEH4lOe6Tl2eY7gItD/xVm5V/qOUEBHPsjZ
gh+N2yYyeIOH1K37cNib08fcsr1u+CFduRZwoTBOfBr9rCvGRdeP6Dwd7+fJ1HYN
Is2BmfioYdSfZ3QdNqSJHVGBrwEpX5YVMz+JgnwGt6fFlP+T72k=

------73086AE8A529CA972B53CC1FB9035D36--


